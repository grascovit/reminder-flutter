import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lembrete/network/api_client.dart';
import 'package:lembrete/models/user.dart';

class AuthService {
  static Future<User> googleSignIn(String idToken) async {
    Response response = await ApiClient.client
        .post('omniauth/google_oauth2', data: {'id_token': idToken});
    final storage = new FlutterSecureStorage();
    await storage.write(key: 'token', value: response.data['token']);

    return User.fromMap(response.data);
  }
}
