import 'dart:convert';
import 'package:dio/dio.dart';

class CategoryProvider {
  Dio _client;

  CategoryProvider(this._client);

  Future getCategories() async {
    try {
      final response = await _client.get(
          '/categories/');
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
          '/categories',data: data);
      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

  Future deleteCategories(data) async {
    try {
      final response = await _client.delete(
          '/categories/${data["id"]}');
      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }


  Future updateCategories(data) async {
    try {
      final response = await _client.put(
          '/categories/${data["id"]}',data: {
            "name":data["name"],
            "color":data["color"]
      });
      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

}
