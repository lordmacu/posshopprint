import 'dart:convert';
import 'package:dio/dio.dart';

class ClientProvider {
  Dio _client;

  ClientProvider(this._client);

  Future getClientes() async {
    try {
      final response = await _client.get(
          '/clients/');
      return json.decode(response.toString());
    } on DioError catch (ex) {
        String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

  Future getTaxes() async {
    try {
      final response = await _client.get(
          '/taxes/');
      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }


  Future createCategories(data) async {
    try {
      final response = await _client.post(
          '/clients',data: data);
      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

  Future deleteClients(data) async {
    try {
      final response = await _client.delete(
          '/clients/${data["id"]}');
      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }


  Future updateCategories(data) async {


    try {
      final response = await _client.put(
          '/clients/${data["id"]}',data: data);
      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

}
