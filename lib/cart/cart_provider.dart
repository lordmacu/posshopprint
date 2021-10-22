import 'dart:convert';
import 'package:dio/dio.dart';

class CartProvider {
  Dio _client;

  CartProvider(this._client);

  Future setTickets() async {
    try {

      var data ={
        "total":"900",
        "cashregister_id":"4",
        "client_id":"1",
        "items":[
          {
            "id":"1",
            "quantity":"2",
            "amount":"300"

          }
        ]
      };

      final response = await _client.post(
          '/tickets?cashregister_id=4',data: data);

      return json.decode(response.toString());
    } on DioError catch (ex) {
        String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

}
