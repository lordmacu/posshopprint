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
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CheckoutContoller extends GetxController {
  var valueCheckout = "10000".obs;
  var balanceCheckout = 0.0.obs;
  var isPanelOpen = false.obs;
  var totalCart = 0.obs;
  var totalCheckout = 0.0.obs;
  var typePayment = 1.obs;
  var email = "".obs;
  var paymentTypesString=[].obs;
  var paymentCheckout=[].obs;

  var tempValue=0.0.obs;
  var tempBalance=0.0.obs;
  var tempTotal=0.0.obs;
  var tempNamePayment="".obs;
  var tempType="".obs;
  var tempId=0.obs;
  var panelControllerDivide = PanelController().obs;
  var panelControllerCheckout = PanelController().obs;


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
  
  recalculateBalance(){
    var total=0.0;
    for(var i =0; i< paymentCheckoutsItems.length; i++){
      total= total+paymentCheckoutsItems[i].balance;
      print("este es el balance ${total}");

    }
    print("este es el total ${total}");
    balanceCheckout.value= int.parse(valueCheckout.value)-total;
  }

  addPayment(){
    paymentCheckoutsItems.add(Payment(paymentItems[0].id, paymentItems[0].name, 0, paymentItems[0].type,0,0));
    recalculatePayments();

  }

  removePayment(){
    paymentCheckoutsItems.removeLast();
    recalculatePayments();
  }

  recalculatePayments(){

    var tempBalance=0.0;
    var noBalance=0;
    for(var o =0; o< paymentCheckoutsItems.length; o++){

      if(paymentCheckoutsItems[o].balance == 0){
        noBalance+=1;
      }
      tempBalance = tempBalance+paymentCheckoutsItems[o].balance;
    }

    print("este es el balance   ${noBalance}");

    var midValue= (int.parse(valueCheckout.value)-tempBalance)/noBalance;

    for(var i =0; i< paymentCheckoutsItems.length; i++){
      if(paymentCheckoutsItems[i].balance==0){
        paymentCheckoutsItems[i].price=midValue;

      }
    }
  }


  setPayments() {
    balanceCheckout.value=double.parse(valueCheckout.value);

    paymentCheckoutsItems.clear();

    paymentCheckoutsItems.add(Payment(paymentItems[0].id, paymentItems[0].name, double.parse(valueCheckout.value),paymentItems[0].type,paymentItems[0].balance,paymentItems[0].totalPaid));

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

          paymentItems.add(Payment(dataJsonGeneral[i]["id"], dataJsonGeneral[i]["name"],0,dataJsonGeneral[i]["method"],0,0));
          paymentTypesString.add(dataJsonGeneral[i]["name"]);
          print("aquiii  ${dataJsonGeneral[i]["name"]}");

        }
      }

      print(" asdfasdf  ${paymentItems}");
    } catch (e) {
      print("aqui esta el error check ${e}");
      return false;
    }
  }
}
