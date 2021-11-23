
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poshop/cart/controllers/CartController.dart';
 import 'package:poshop/products/controllers/ProductContoller.dart';
import 'package:poshop/products/model/Product.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class DiscountHomeController extends GetxController{

  int indexItem;
  CartContoller controlelrCart =Get.find();


  GroupController controller;


  @override
  void onInit() {

    super.onInit();



    controller = GroupController(isMultipleSelection: true);

  }

  getItemsDiscounts(){
    var item=controlelrCart.items[controlelrCart.indexSingleCart.value];


    List<int> discountsIds=[];
    if(item.discount!=null){
      for(var d = 0; d <item.discount.length; d ++){
        discountsIds.add(item.discount[d].discount_Id);
      }
      print("aquiiiii el item discountitem  ${discountsIds}");

      controller = GroupController(isMultipleSelection: true,initSelectedItem: discountsIds);

    }else{
      controller = GroupController(isMultipleSelection: true,initSelectedItem: []);

    }

  }


}