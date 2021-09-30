import 'dart:convert';
import 'package:dio/dio.dart';

class CategoryProvider {
  Dio _client;

  CategoryProvider(this._client);

  Future getCategories() async {
    try {
      final response = await _client.get(
          '/category/');

      return json.decode(response.toString());
    } on DioError catch (ex) {
        String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

}
