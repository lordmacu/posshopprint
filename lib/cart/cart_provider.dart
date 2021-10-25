import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:poshop/cart/model/Cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider {
  Dio _client;

  CartProvider(this._client);

  Future setTickets(List<Cart> items,total) async {
    var prefs = await SharedPreferences.getInstance();



    var itemsSave=[];
    var totalCart=0;
    for(var i =0; i<items.length; i++){

      var localTotal=items[i].product.salesPrice*items[i].numberItem;
      itemsSave.add({
        "id":"${items[i].product.id}",
        "quantity":"${items[i].numberItem}",
        "amount":"${localTotal}",
      });

      totalCart+=localTotal;

    }

    var data ={
      "total":"${totalCart}",
      "email":"f",
      "cashregister_id":prefs.getInt("cashierId"),
    //  "client_id":"1",
      "items":itemsSave
    };

    print("items  ${data}   total  ${totalCart}");
    try {




      final response = await _client.post(
          '/tickets',data: data);

     return json.decode(response.toString());
    } on DioError catch (ex) {
        String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

}
