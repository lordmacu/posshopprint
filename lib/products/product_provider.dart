import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider {
  Dio _client;

  ProductProvider(this._client);
  SharedPreferences prefs;

  Future getProducts() async {
    prefs = await SharedPreferences.getInstance();

    var outletId="${prefs.getInt("outletId")}";
    print("este es el outlet Id  ${outletId}");
    try {

      final response = await _client.get(
          '/items?devMode=true&itemsPerPage=20&page=1');

      return json.decode(response.toString());
    } on DioError catch (ex) {
        String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

  Future updateProduct(product,id) async {
    prefs = await SharedPreferences.getInstance();

    var outletId="${prefs.getInt("outletId")}";

    try {

      final response = await _client.post(
          '/items/${id}',data: product);

      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }


  Future createProduct(product) async {
    prefs = await SharedPreferences.getInstance();

    var outletId="${prefs.getInt("outletId")}";
    print("este es el outlet Id  ${outletId}");
    try {
      final response = await _client.post(
          '/items',data: product);

      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }




}
