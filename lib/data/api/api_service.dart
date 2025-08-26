import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:paisay_da_da/core/themes/log.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'api_config.dart';

enum RequestMethod {
  post,
  get,
  put,
  patch,
  delete,
  GET,
}

class ApiService {
  static late dio.CancelToken cancelToken;

  static Future<Map<String, dynamic>?> request(
      {required RequestMethod method,
      data,
      queryParameters,
      Function(int sent, int total)? onProgress,
      bool requestWithRefreshToken = false,
      required path}) async {
    final token = await HiveDatabase.getValue(HiveDatabase.tokenKey);

    Log.i(
      'method: ${method.name}\nqueryParameters: $queryParameters\ndata: $data\nURL: $path\n${"token : $token"}',
    );

    try {
      // if (requestWithRefreshToken) {
      //   ApiConfig().dio.options.headers["authtoken"] =
      //       "${HiveDatabase.getValue(HiveDatabase.refreshToken)}";
      // } else {
      //   ApiConfig().dio.options.headers["authtoken"] =
      //       "${HiveDatabase.getValue(HiveDatabase.accessToken)}";
      // }
      ApiConfig().dio.options.method = method.name;
      cancelToken = dio.CancelToken();

      // dio.Response res = ApiConfig().dio.get(path)

      dio.Response response = await ApiConfig().dio.request(
            path,
            data: data,
            queryParameters: queryParameters,
            onSendProgress: onProgress ??
                (int sent, int total) => Log.d("SENT: $sent TOTAL: $total"),
            cancelToken: cancelToken,
            options: Options(
                followRedirects: false,
                validateStatus: (status) {
                  Log.d("Validate Status API SERVICE: $status");
                  return status! < 500;
                },
                headers: {
                  HttpHeaders.contentTypeHeader: data is FormData
                      ? "multipart/form-data"
                      : "application/x-www-form-urlencoded",
                  HttpHeaders.authorizationHeader: "Bearer $token", // ✅ correct
                }),
          );

      Log.w(
          "Path : $path From the api service class: ${response.data} and the status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return response.data;
      }
    } on dio.DioException catch (e) {
      Log.e("Exception Type: ${e.type}");
      Log.e("DioException $path: $e");
      Log.e("Status Code: ${e.response?.statusCode}");

      // If the status code of new access token is 401, then redirect the user to the login screen
      if (e.response?.statusCode == 401) {
        Log.d('User is not authenticated, redirecting to login screen');
      }

      if (e.response?.statusCode != 500) {
        return e.response?.data;
      }
    }

    return null;
  }
}
