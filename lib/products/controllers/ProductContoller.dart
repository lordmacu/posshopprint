
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poshop/products/model/Product.dart';


import 'package:poshop/products/product_provider.dart';
import 'package:poshop/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

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

  //  try{
      var data = await _endpointProvider.getProducts();

     if(data["success"]){
        var dataJsonGeneral=(data["data"]);
        var dataJson=dataJsonGeneral["data"];
        List<Product> productsLocal=[];



        for(var i = 0 ; i<  dataJson.length; i++){

          Product product=Product(dataJson[i]["id"], dataJson[i]["item_name"]);
          product.type=dataJson[i]["type"];
          product.color=dataJson[i]["color"];
          product.image=dataJson[i]["wareImgName"];
          product.categoryId=dataJson[i]["idCategory"];
          product.barCode=dataJson[i]["barcode"];
          product.freePrice=dataJson[i]["freePrice"];
          product.divisible=dataJson[i]["divisible"];
          product.idDefaultSupplier=dataJson[i]["idDefaultSupplier"];
          product.idOrg=dataJson[i]["idOrg"];
          product.idUserCreated=dataJson[i]["id_user_created"];
          product.idUserUpdate=dataJson[i]["id_user_updated"];
          product.primeCost=dataJson[i]["primeCost"];
          product.keepCount=dataJson[i]["keepCount"];
          product.purchaseCost=dataJson[i]["purchaseCost"];
          product.salesPrice=dataJson[i]["salePrice"];
          product.shape=dataJson[i]["shape"];

            productsLocal.add(product);
        }

        products.assignAll(productsLocal);

        return true;
      }
  /*  }catch(e){
      print("aqui esta el error ${e}");
      return false;
    }*/
  }

}