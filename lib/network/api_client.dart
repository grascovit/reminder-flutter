import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  ApiClient._internal();

  static final ApiClient instance = ApiClient._internal();
  static Dio _dio;

  static get client {
    _dio ??= Dio(BaseOptions(baseUrl: DotEnv().env['API_BASE_URL']));

    return _dio;
  }

  static get authenticatedClient {
    _dio ??= client;
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      final storage = new FlutterSecureStorage();
      final String token = await storage.read(key: 'token');
      options.headers['Authorization'] = 'Bearer $token';

      return options;
    }));

    return _dio;
  }
}
