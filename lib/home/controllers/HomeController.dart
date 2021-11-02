
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'package:poshop/products/controllers/ProductContoller.dart';
import 'package:poshop/products/model/Product.dart';

import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class HomeContoller extends GetxController{
  ProductContoller controllerProduct = Get.put(ProductContoller());

  Rx<ScrollController> controllerCartList=  ScrollController().obs;

  Rx<ItemScrollController>   itemScrollController = ItemScrollController().obs;
  Rx<ItemPositionsListener>   itemPositionsListener = ItemPositionsListener.create().obs;


  var positionMenu=0.obs;
  var categorySelect=0.obs;
  var isShowPayment=false.obs;

  jumpToIndex(index){

    itemScrollController.value.scrollTo(
        index: index,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOutCubic);

  }

  findProductIndex(barcodeScanRes) async{

    Product product= await controllerProduct.getProductByCode(barcodeScanRes);
    var index= 0;
    if(product!=null){
      for(var i =0 ; i <  controllerProduct.products.length ; i ++){
        if( controllerProduct.products[i].id == product.id ){
          index=i;
        }
      }
    }



     return {
      "product": product,
       "index":index
     };

  }

}