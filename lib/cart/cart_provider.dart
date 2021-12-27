import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:poshop/cart/controllers/CartController.dart';
import 'package:poshop/cart/model/Cart.dart';
import 'package:poshop/checkout/controllers/CheckoutController.dart';
import 'package:poshop/clients/controllers/ClientController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider {
  Dio _client;

  CartProvider(this._client);
  CheckoutContoller controllerCheckout = Get.find();
  ClientContoller controllerClient = Get.find();
  CartContoller controllerCart = Get.find();

  Future setTickets(List<Cart> items,total) async {
    var prefs = await SharedPreferences.getInstance();




    var itemsSave=[];
    var totalCart=0.0;
    for(var i =0; i<items.length; i++){

     var  localTotal = items[i].product.salesPrice * items[i].numberItem;

      var discounts=[];

      if(items[i].discount!=null){
        for(var d =0; d<items[i].discount.length; d++) {
          discounts.add({
            "discount_id":"${items[i].discount[d].discount_Id}",
            "total_discount":"${items[i].discount[d].total_discount}"
          });
        }
      }

      print("este es el sales price  ${items[i].product.salesPrice}  y esta es la cantidad  ${items[i].numberItem} ");


        itemsSave.add({
        "id":"${items[i].product.id}",
        "quantity":"${items[i].numberItem}",
        "amount":"${items[i].product.salesPrice * items[i].numberItem}", "discounts":discounts

      });



      totalCart+=localTotal;
    }

    var itemsPayment=[];

    for(var i =0; i<controllerCheckout.paymentCheckoutsItems.length; i++) {
      itemsPayment.add({"id":"${controllerCheckout.paymentCheckoutsItems[i].id}","amount":"${controllerCheckout.paymentCheckoutsItems[i].price}"});
    }



    var taxesPayment=[];

    if(controllerCart.taxes!=null){
      for(var t =0; t<controllerCart.taxes.length; t++) {
        taxesPayment.add({"id":controllerCart.taxes[t].id,"total_tax":controllerCart.taxes[t].total_tax});
      }
    }



      var data ={
      "total":"${totalCart.toInt()}",
      "email":controllerCheckout.email.value,
      "cashregister_id":"${prefs.getInt("cashierId")}",

        "client_id":controllerClient.selectedClient.value > 0 ? "${controllerClient.selectedClient.value}" : null,
        "items":itemsSave,
        "payments":itemsPayment,
        "taxes":taxesPayment,

    };

    controllerClient.selectedClient.value=0;
    controllerClient.selectedClientName.value="";

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
