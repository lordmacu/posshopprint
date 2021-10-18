import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poshop/products/model/Product.dart';

import 'package:poshop/products/product_provider.dart';
import 'package:poshop/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class ProductContoller extends GetxController {

  Rx<PanelController> panelController = PanelController().obs;

  var isOpenCreator= false.obs;
  var indificualTicket = false.obs;
  var categorySelect = 0.obs;
  var selectedColor = 0xffffffff.obs;
  var isSelectedColor = false.obs;
  var selectedCategory = 0.obs;
  var selectedCategoryName = "".obs;
  var isFormSelected = false.obs;
  var selectedForm = "square".obs;
  var step = 0.obs;
  var products = [].obs;

  var item_name = "".obs;
  var item_id = "0".obs;
  var article = "".obs;
  var representacion = "color_y_forma".obs;
  var reference = "".obs;
  var color = "#E0E0E0".obs;
  var shape = "SQUARE".obs;
  var allOutlets = "1".obs;
  var divisible = false.obs;
  var keepCount = "0".obs;
  var salePrice = "0".obs;
  var primeCost = "0".obs;
  var barcode = "".obs;
  var type = "0".obs;
  var outlets = [].obs;
  var idCategory = "0".obs;
  var formKey = GlobalKey<FormState>().obs;
  var image = "".obs;

  var isImagen=false.obs;

  Client _client = new Client();
  var _endpointProvider;
  SharedPreferences prefs;

  @override
  void onInit() async {
    var prefs = await SharedPreferences.getInstance();
    _endpointProvider =
        new ProductProvider(_client.init(prefs.getString("token")));
    getProducts();
  }

  resetCreationProduct(){

    formKey.value.currentState.reset();

     item_name.value = "";
     item_id.value = "0";
     article.value = "";
     representacion.value = "color_y_forma";
     reference.value = "";
     color.value = "#E0E0E0";
     shape.value = "SQUARE";
     allOutlets.value = "1";
     divisible.value = false;
     keepCount.value = "0";
     salePrice.value = "0";
     primeCost.value = "0";
     barcode.value = "";
     type.value = "0";
     outlets.value = [];
     idCategory.value = "0";

  }

  Future createProduct() async {
   var prefs = await SharedPreferences.getInstance();

   var outlet=prefs.getInt("outletId");
    try {


      var productObject={
        "item_name": item_name.value,
        "article": reference.value,
        "representacion": isImagen.value ?  "color_y_forma" : "imagen",
        "color": color.value,
        "shape":  shape.value,
        "allOutlets": allOutlets.value,
        "divisible": divisible.value ? "1" : "0",
        "keepCount": keepCount.value,
        "salePrice": salePrice.value,
        "primeCost": primeCost.value,
        "type": type.value,
        "idCategory":selectedCategory.value,
        "outlets": [
          {
            "checkbox": "1",
            "outlet_id": "${outlet}",
            "precio": salePrice
          }
        ],

      };


      print("aquiii el objeto  ${productObject}");
      var data=null;

   data = await _endpointProvider.createProduct(productObject);
   getProducts();

      if (data["success"]) {
        return true;
      }
    } catch (e) {
      print("aqui esta el error ${e.toString()}");
      return false;
    }
  }

  Future updateProduct() async {
    var prefs = await SharedPreferences.getInstance();

    var outlet=prefs.getInt("outletId");
    try {


      var productObject={
        "item_name": item_name.value,
        "article": reference.value,
        "representacion": isImagen.value ?  "color_y_forma" : "imagen",
        "color": color.value,
        "shape":  shape.value,
        "allOutlets": allOutlets.value,
        "divisible": divisible.value ? "1" : "0",
        "keepCount": keepCount.value,
        "salePrice": salePrice.value,
        "primeCost": primeCost.value,
        "type": type.value,
        "idCategory":selectedCategory.value,
        "outlets": [
          {
            "checkbox": "1",
            "outlet_id": "${outlet}",
            "precio": salePrice
          }
        ],

      };


      print("aquiii el objeto  ${productObject}");
      var data=null;
      data = await _endpointProvider.updateProduct(productObject,item_id);

      getProducts();

      if (data["success"]) {
        return true;
      }
    } catch (e) {
      print("aqui esta el error ${e.toString()}");
      return false;
    }
  }

  getProducts() async {
    try {
      var data = await _endpointProvider.getProducts();

      if (data["success"]) {
        var dataJsonGeneral = (data["data"]);
        var dataJson = dataJsonGeneral["data"];
        List<Product> productsLocal = [];

        for (var i = 0; i < dataJson.length; i++) {
          Product product =
              Product(dataJson[i]["id"], dataJson[i]["item_name"]);
          product.type = dataJson[i]["type"];
          product.color = dataJson[i]["color"];
          product.image = dataJson[i]["wareImgName"];
          product.categoryId = dataJson[i]["idCategory"];
          product.barCode = dataJson[i]["barcode"];
          product.freePrice = dataJson[i]["freePrice"];
          product.divisible = dataJson[i]["divisible"];
          product.idDefaultSupplier = dataJson[i]["idDefaultSupplier"];
          product.idOrg = dataJson[i]["idOrg"];
          product.idUserCreated = dataJson[i]["id_user_created"];
          product.idUserUpdate = dataJson[i]["id_user_updated"];
          product.primeCost = dataJson[i]["primeCost"];
          product.keepCount = dataJson[i]["keepCount"];
          product.purchaseCost = dataJson[i]["purchaseCost"];
          product.salesPrice = dataJson[i]["salePrice"];
          product.shape = dataJson[i]["shape"];

          productsLocal.add(product);
        }

        products.assignAll(productsLocal);

        return true;
      }
    } catch (e) {
      print("aqui esta el error ${e}");
      return false;
    }
  }
}
