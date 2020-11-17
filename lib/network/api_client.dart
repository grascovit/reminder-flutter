import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  ApiClient._internal();

  static final ApiClient instance = ApiClient._internal();
  static Dio _dio;

  static get client {
    _dio ??= Dio(BaseOptions(baseUrl: DotEnv().env['API_BASE_URL']));

    return _dio;
  }
}
