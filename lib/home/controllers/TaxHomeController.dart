
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poshop/api_client.dart';
import 'package:poshop/cart/controllers/CartController.dart';
import 'package:poshop/discounts/discount_provider.dart';
 import 'package:poshop/products/controllers/ProductContoller.dart';
import 'package:poshop/products/model/Product.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaxHomeController extends GetxController{

  int indexItem;
  CartContoller controlelrCart =Get.find();


  GroupController controller;
  var _endpointProvider;
  Client _client = new Client();


  @override
  void onInit()  async{

    super.onInit();

    var prefs = await SharedPreferences.getInstance();
    _endpointProvider =
    new DiscountProvider(_client.init(prefs.getString("token")));
    controller = GroupController(isMultipleSelection: true);

    getTaxes();

  }

  getTaxes() async {
    try {
      var data = await _endpointProvider.getTaxes();

      if (data["success"]) {


      }

    } catch (e) {
      print("aqui esta el error cinco ${e}");
      return false;
    }
  }

  getItemsDiscounts(){
    var item=controlelrCart.items[controlelrCart.indexSingleCart.value];

    List<int> discountsIds=[];
    if(item.discount!=null){
      for(var d = 0; d <item.discount.length; d ++){
        discountsIds.add(item.discount[d].discount_Id);
      }

      controller = GroupController(isMultipleSelection: true,initSelectedItem: discountsIds);

    }else{
      controller = GroupController(isMultipleSelection: true,initSelectedItem: []);

    }

  }


}