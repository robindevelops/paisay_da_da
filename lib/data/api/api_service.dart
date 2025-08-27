import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/themes/log.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/ui/auth/auth_screen.dart';
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

  static Future<Map<String, dynamic>?> request({
    required RequestMethod method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Function(int sent, int total)? onProgress,
    bool requestWithRefreshToken = false,
    required String path,
    required BuildContext context,
  }) async {
    final token = await HiveDatabase.getValue(HiveDatabase.tokenKey);

    Log.i(
      'method: ${method.name}\nqueryParameters: $queryParameters\ndata: $data\nURL: $path\nToken: $token',
    );

    try {
      // Set HTTP method
      ApiConfig().dio.options.method = method.name;
      cancelToken = dio.CancelToken();

      // Make the request
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
                return true; // accept all status codes
              },
              headers: {
                HttpHeaders.contentTypeHeader: data is dio.FormData
                    ? "multipart/form-data"
                    : "application/x-www-form-urlencoded",
                HttpHeaders.authorizationHeader: "Bearer $token",
              },
            ),
          );

      Log.w(
          "Path: $path | Response: ${response.data} | Status Code: ${response.statusCode}");

      // Handle unauthorized
      if (response.statusCode == 401) {
        Log.d('User is not authenticated, redirecting to login screen');

        // Clear login info
        await HiveDatabase.storeValue("islogin", false);
        // Show an alert dialog using global navigator key
        showDialog(
          context: context,
          barrierDismissible: false, // user must tap button
          builder: (context) {
            return AlertDialog(
              title: Text("Access Denied"),
              content: Text("You are Banned"),
              backgroundColor: Colors.white,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // close dialog
                    // Navigate to AuthScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AuthScreen();
                        },
                      ),
                    );
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
        return null;
      }

      // Return API data
      return response.data;
    } on dio.DioException catch (e) {
      Log.e("DioException $path: $e");
      Log.e("Exception Type: ${e.type}");
      Log.e("Status Code: ${e.response?.statusCode}");

      if (e.response?.statusCode != 500) {
        return e.response?.data;
      }
    } catch (e) {
      Log.e("Unexpected error: $e");
    }

    return null;
  }
}
