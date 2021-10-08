
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poshop/products/model/Product.dart';


import 'package:poshop/products/product_provider.dart';
import 'package:poshop/service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductContoller extends GetxController{

  var indificualTicket=false.obs;
  var categorySelect=0.obs;
  var selectedColor = "0xff298dcf".obs;
  var isFormSelected = false.obs;
  var selectedForm = "square".obs;
  var step = 0.obs;
  var products=[].obs;


  Client _client = new Client();
  var _endpointProvider;
  SharedPreferences prefs;


  @override
  void onInit() async{
    var  prefs = await SharedPreferences.getInstance();
    _endpointProvider = new ProductProvider(_client.init(prefs.getString("token")));
    getProducts();
  }


  getProducts() async{

    try{
      var data = await _endpointProvider.getProducts();

     if(data["success"]){
        var dataJson=(data["data"]);
        List<Product> products=[];



        for(var i = 0 ; i<  dataJson.length; i++){
          //products.add(Product(dataJson[i]["id"], dataJson[i]["item_name"]));
        }

     //   items.value=categoryes;

        return true;
      }
    }catch(e){
      print("aqui esta el error ${e}");
      return false;
    }
  }

}