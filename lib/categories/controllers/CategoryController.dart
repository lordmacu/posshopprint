import 'dart:convert';

import 'package:get/get.dart';
import 'package:poshop/auth/controllers/AuthController.dart';
import 'package:poshop/categories/category_provider.dart';
import 'package:poshop/categories/models/Category.dart';
import 'package:poshop/checkout/controllers/CheckoutController.dart';
import 'package:poshop/home/controllers/HomeController.dart';
import 'package:poshop/home/model/Tax.dart';
import 'package:poshop/products/controllers/ProductContoller.dart';
import 'package:poshop/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class CategoryContoller extends GetxController {
  AuthContoller controllerAuth = AuthContoller();
  ProductsContoller controllerProduct = Get.find();

  CheckoutContoller controllerCheckout = Get.put(CheckoutContoller());
  HomeContoller controllerHome = Get.put(HomeContoller());

  var panelController = PanelController().obs;

  var isPanelOpen = false.obs;
  var categorySelect = 0.obs;
  var categoryName = "".obs;
  var categoryColor = "".obs;
  var categoryId = 0.obs;
  RxList<Category> items = RxList<Category>();
  RxList<Tax> taxes = RxList<Tax>();

  Client _client = new Client();
  var _endpointProvider;
  SharedPreferences prefs;

  @override
  void onInit() async {
    //var  prefs = await SharedPreferences.getInstance();
    //_endpointProvider = new CategoryProvider(_client.init(prefs.getString("token")));
    //getCategories();
  }

  createCategories() async {
    var prefs = await SharedPreferences.getInstance();
    _endpointProvider =
        new CategoryProvider(_client.init(prefs.getString("token")));

    try {
      var data = await _endpointProvider
          .createCategories({"name": categoryName, "color": categoryColor});
      getCategories();

      if (data["success"]) {
        return "ok";
      }
    } catch (e) {
      return replaceExeptionText(e);
    }
  }

  deleteCategories() async {
    var prefs = await SharedPreferences.getInstance();

    try {
      var data =
          await _endpointProvider.deleteCategories({"id": "${categoryId}"});
      getCategories();

      if (data["success"]) {
        return "ok";
      }
    } catch (e) {
      return replaceExeptionText(e.message);
    }
  }

  updateCategories() async {
    var prefs = await SharedPreferences.getInstance();

    try {
      var data = await _endpointProvider.updateCategories({
        "name": categoryName,
        "color": categoryColor,
        "id": "${categoryId}"
      });
      getCategories();

      if (data["success"]) {
        return "ok";
      }
    } catch (e) {
      return replaceExeptionText(e.message);
    }
  }

  getTaxes() async {
    var prefs = await SharedPreferences.getInstance();
    taxes.refresh();
    taxes.clear();
    taxes.refresh();

    try {
      var data = await _endpointProvider.getTaxes();

      List<Tax> taxesLocal = [];
      if (data["success"]) {
        var dataJson = data["data"];
        for (var i = 0; i < dataJson.length; i++) {
          Tax tax = Tax(
              dataJson[i]["id"],
              dataJson[i]["idOrg"],
              dataJson[i]["type"],
              dataJson[i]["name"],
              dataJson[i]["rate"],
              dataJson[i]["allowedForAllOutlets"],
              dataJson[i]["applyForAllNewWares"],
              dataJson[i]["applyToAllWares"]);

          taxesLocal.add(tax);
        }

        taxes.assignAll(taxesLocal);
      }
    } catch (e) {
      return false;
    }
  }

  getCategories() async {
    var prefs = await SharedPreferences.getInstance();

    _endpointProvider =
        new CategoryProvider(_client.init(prefs.getString("token")));

    items.refresh();

    items.clear();

    items.refresh();

    // try{
    var data = await _endpointProvider.getCategories();

    if (data["success"]) {
      var dataJson = (data["data"]);
      List<Category> categoryes = [];

      if (dataJson.length > 0) {
        categorySelect.value = dataJson[0]["id"];
      }

      for (var i = 0; i < dataJson.length; i++) {
        categoryes.add(Category(dataJson[i]["id"], dataJson[i]["idOrg"],
            dataJson[i]["name"], dataJson[i]["color"]));
      }

      items.assignAll(categoryes);

      controllerProduct.getProducts(controllerProduct.search.value);
      getTaxes();

      controllerCheckout.getPayments();

      return true;
    }
    // }catch(e){

    // return false;
    // }
  }

  replaceExeptionText(String text) {
    return jsonDecode(text.replaceAll("Exception: ", ""));
  }
}
