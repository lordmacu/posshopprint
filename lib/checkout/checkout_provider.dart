import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:poshop/cart/model/Cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutProvider {
  Dio _client;

  CheckoutProvider(this._client);

  Future getPayments() async {
    try {
      final response = await _client.get(
          '/payments');
      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

}
