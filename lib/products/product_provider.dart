import 'dart:convert';
import 'package:dio/dio.dart';

class ProductProvider {
  Dio _client;

  ProductProvider(this._client);

  Future getProducts() async {
    try {
      final response = await _client.get(
          '/items?outlet_id=31&category_id=13&itemsPerPage=10&page=1');
      return json.decode(response.toString());
    } on DioError catch (ex) {
        String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

}
