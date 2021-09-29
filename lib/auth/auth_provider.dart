import 'dart:convert';
import 'package:dio/dio.dart';

class AuthProvider {
  Dio _client;

  AuthProvider(this._client);

  Future login(email,password) async {
    try {
      final response = await _client.post(
          '/auth/login',data: {"email":"cristianberrios@gmail.com","password":"12345678."});

      return json.decode(response.toString());
    } on DioError catch (ex) {
        String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

}
