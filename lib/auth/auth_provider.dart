import 'dart:convert';
import 'package:dio/dio.dart';

class AuthProvider {
  Dio _client;

  AuthProvider(this._client);

  Future login(email,password) async {
    try {
      final response = await _client.post(
          '/auth/login',data: {"email":email,"password":password});

      return json.decode(response.toString());
    } on DioError catch (ex) {
        String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

  Future loginPin(pin,idOrg) async {
    try {
      final response = await _client.post(
          '/auth/login',data: {"pin":pin,"id_org":idOrg});

      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

  Future register(email,password,business) async {
    try {
      final response = await _client.post(
          '/auth/register',data: {"email":email,"name":email,"password":email,"business_name":business});

      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

}
