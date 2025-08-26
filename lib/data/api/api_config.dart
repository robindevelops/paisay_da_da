import 'package:dio/dio.dart';
import 'package:paisay_da_da/data/api/api_path.dart';

class ApiConfig {
  static final ApiConfig _instance = ApiConfig._internal();
  factory ApiConfig() => _instance;

  late Dio dio;

  ApiConfig._internal() {
    //creates the singleton instance
    dio = Dio();
    // dio.interceptors.add(LogInterceptor(requestHeader: true),);
    // Set default configs
    dio.options.baseUrl = ApiPaths.baseURL;
    dio.options.connectTimeout = const Duration(seconds: 20); //10s
    dio.options.receiveTimeout = const Duration(seconds: 20);
  }
}
