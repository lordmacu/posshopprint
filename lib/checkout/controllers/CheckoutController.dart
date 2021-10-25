import 'dart:convert';

import 'package:get/get.dart';
import 'package:poshop/auth/controllers/AuthController.dart';
import 'package:poshop/categories/category_provider.dart';
import 'package:poshop/categories/models/Category.dart';
import 'package:poshop/checkout/checkout_provider.dart';
import 'package:poshop/checkout/models/Payment.dart';

import 'package:poshop/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class CheckoutContoller extends GetxController {
  var valueCheckout = "10000".obs;
  var isPanelOpen = false.obs;
  var totalCart = 0.obs;
  var totalCheckout = 0.obs;
  var typePayment = 1.obs;
  var email = "".obs;
  var paymentTypesString=[].obs;

  RxList<Payment> paymentItems = RxList<Payment>();
  RxList<Payment> paymentCheckoutsItems = RxList<Payment>();

  Client _client = new Client();
  var _endpointProvider;
  SharedPreferences prefs;

  @override
  void onInit() async {
    var prefs = await SharedPreferences.getInstance();
    _endpointProvider =
        new CheckoutProvider(_client.init(prefs.getString("token")));
    getPayments();
  }

  addPayment(){
    paymentCheckoutsItems.add(Payment(paymentItems[0].id, paymentItems[0].name, 0));
    recalculatePayments();

  }

  removePayment(){
    paymentCheckoutsItems.removeLast();
    recalculatePayments();
  }

  recalculatePayments(){
    var midValue= int.parse(valueCheckout.value)/paymentCheckoutsItems.length;

    for(var i =0; i< paymentCheckoutsItems.length; i++){
      paymentCheckoutsItems[i].price=midValue;
    }

  }


  setPayments() {
    paymentCheckoutsItems.clear();
    var midValue= int.parse(valueCheckout.value)/2;
    paymentCheckoutsItems.add(Payment(paymentItems[0].id, paymentItems[0].name, midValue));
    paymentCheckoutsItems.add(Payment(paymentItems[0].id, paymentItems[0].name, midValue));

    print("aquiii setpayments");
  }

  formatedNumber(number) {
    return number;
  }

  getPayments() async {
    paymentItems.clear();
    try {
      var data = await _endpointProvider.getPayments();

      if (data["success"]) {
        var dataJsonGeneral = (data["data"]);

        for (var i = 0; i < dataJsonGeneral.length; i++) {

          paymentItems.add(Payment(dataJsonGeneral[i]["id"], dataJsonGeneral[i]["name"],0));
          paymentTypesString.add(dataJsonGeneral[i]["name"]);
          print("aquiii  ${dataJsonGeneral[i]["name"]}");

        }
      }

      print(" asdfasdf  ${paymentItems}");
    } catch (e) {
      print("aqui esta el error ${e}");
      return false;
    }
  }
}
