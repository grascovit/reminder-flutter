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
    final storage = new FlutterSecureStorage();

    _dio ??= client;
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      final String token = await storage.read(key: 'token');
      options.headers['Authorization'] = 'Bearer $token';

      return options;
    }, onResponse: (Response response) async {
      final String accessToken = response.headers.value('Access-Token');
      await storage.write(key: 'token', value: accessToken);

      return response;
    }));

    return _dio;
  }
}
