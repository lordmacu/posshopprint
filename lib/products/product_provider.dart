import 'dart:convert';
import 'package:dio/dio.dart';

class ProductProvider {
  Dio _client;

  ProductProvider(this._client);

  Future getProducts() async {
    try {
      final response = await _client.get(
          '/items-disponibles?outlet_id=28&category_id=1&itemsPerPage=10&page=1');
      return json.decode(response.toString());
    } on DioError catch (ex) {
        String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

}
