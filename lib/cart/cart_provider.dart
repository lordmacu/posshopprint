import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:poshop/cart/controllers/CartController.dart';
import 'package:poshop/cart/model/Cart.dart';
import 'package:poshop/checkout/controllers/CheckoutController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider {
  Dio _client;

  CartProvider(this._client);
  CheckoutContoller controllerCheckout = Get.find();
  CartContoller controllerCart = Get.find();

  Future setTickets(List<Cart> items,total) async {
    var prefs = await SharedPreferences.getInstance();



    print("aaantesdelositemsmsmsmsms  ${controllerCart.items}");

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

    var itemsPayment=[];

    for(var i =0; i<controllerCheckout.paymentCheckoutsItems.length; i++) {
      itemsPayment.add({"id":"${controllerCheckout.paymentCheckoutsItems[i].id}","amount":"${controllerCheckout.paymentCheckoutsItems[i].price}"});
    }

      var data ={
      "total":"${totalCart}",
      "email":controllerCheckout.email.value,
      "cashregister_id":"${prefs.getInt("cashierId")}",
    //  "client_id":"1",
        "items":itemsSave,
        "payments":itemsPayment,

    };

    print("items queseenviandooooo ${data}   total  ${totalCart}  ${controllerCheckout.paymentCheckoutsItems}");
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
