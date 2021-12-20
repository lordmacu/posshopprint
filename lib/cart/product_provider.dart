import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProductProvider {
  Dio _client;

  ProductProvider(this._client);
  SharedPreferences prefs;

  Future getProducts() async {
    try {
   /*   final response = await _client.get(
          '/items?outlet_id=31&category_id=13&itemsPerPage=10&page=1');*/

      prefs = await SharedPreferences.getInstance();

      var outletId="${prefs.getInt("outletId")}";

      final response = await _client.get(
          '/items?outlet_id=${outletId}&itemsPerPage=1000&page=1&search=');

      return json.decode(response.toString());
    } on DioError catch (ex) {
        String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

}
