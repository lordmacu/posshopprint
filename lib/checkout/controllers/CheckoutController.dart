
import 'dart:convert';

import 'package:get/get.dart';
import 'package:poshop/auth/controllers/AuthController.dart';
import 'package:poshop/categories/category_provider.dart';
import 'package:poshop/categories/models/Category.dart';

import 'package:poshop/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class CheckoutContoller extends GetxController{


  var valueCheckout= "10000".obs;
  var isPanelOpen= false.obs;

  var typePayment= 1.obs;
  @override
  void onInit() async{

  }


  formatedNumber(number) {




    return number;
  }

}
