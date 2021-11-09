import 'dart:convert';
import 'package:dio/dio.dart';

class AuthProvider {
  Dio _client;

  AuthProvider(this._client);

  Future login(email,password) async {
    try {
      final response = await _client.post(
          '/auth/login',data: {"email":email.toLowerCase().trim(),"password":password.trim()});

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
          '/auth/register',data: {"email":email.toLowerCase().trim(),"name":email.toLowerCase().trim(),"password":password.trim(),"business_name":business});

      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

  Future outletAvailable() async {
    try {
      final response = await _client.get(
          '/outlets-disponibles');

      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }



  Future cashRegister(cashier) async {
    try {
      final response = await _client.post(
          '/cash-register/${cashier}/activate');

      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }
}
