import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:poshop/api_client.dart';
import 'package:poshop/discounts/discount_provider.dart';
import 'package:poshop/discounts/model/Discount.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DiscountContoller extends GetxController {
  var indificualTicket = false.obs;
  var categorySelect = 0.obs;

  RxList<Discount> discounts = RxList<Discount>();
  Rx<Discount> DiscountSingular = Rx<Discount>();
  Rx<int> indexTicket = Rx<int>();
  var typeDiscount = true.obs;
  var nameDiscount = "".obs;
  var valueDiscount = "".obs;
  var panelController = PanelController().obs;
  var formKey = GlobalKey<FormState>().obs;

  Client _client = new Client();
  var _endpointProvider;
  SharedPreferences prefs;

  @override
  void onInit() async {
    var prefs = await SharedPreferences.getInstance();
    _endpointProvider =
        new DiscountProvider(_client.init(prefs.getString("token")));
  }

  Future deleteDiscounts(id) async {
    try {
      var data = await _endpointProvider.deleteDiscount({"id": id});

      if (data["success"]) {
        getDiscounts();
      }
      return "ok";
    } catch (e) {
      var json = replaceExeptionText(e.toString());

      return json;
    }
  }

  Future editDiscounts() async {
    try {
      var data = await _endpointProvider.editDiscount({
        "name": nameDiscount.value,
        "calculationType": DiscountSingular.value.calculationType,
        "limitedAccess": 0,
        "value": DiscountSingular.value.value,
        "id": DiscountSingular.value.id
      });

      DiscountSingular.value.name = "";
      DiscountSingular.value.calculationType = "";
      DiscountSingular.value.value = "";
      DiscountSingular.value.id = null;
      typeDiscount.value = true;

      if (data["success"]) {
        getDiscounts();
      }
      return "ok";
    } catch (e) {
      var json = replaceExeptionText(e.toString());

      return json;
    }
  }

  Future createDiscounts() async {
    try {
      var data = await _endpointProvider.createDiscount({
        "name": DiscountSingular.value.name,
        "calculationType": DiscountSingular.value.calculationType,
        "limitedAccess": 0,
        "value": DiscountSingular.value.value
      });
      DiscountSingular.value.name = "";
      DiscountSingular.value.calculationType = "";
      DiscountSingular.value.value = "";
      typeDiscount.value = true;

      if (data["success"]) {
        getDiscounts();
      }
      return "ok";
    } catch (e) {
      var json = replaceExeptionText(e.toString());

      return json;
    }
  }

  replaceExeptionText(String text) {
    return jsonDecode(text.replaceAll("Exception: ", ""));
  }

  getDiscounts() async {
    var prefs = await SharedPreferences.getInstance();

    _endpointProvider =
        new DiscountProvider(_client.init(prefs.getString("token")));
    discounts.clear();
    discounts.refresh();
    DiscountSingular.refresh();

    try {
      var data = await _endpointProvider.getDiscounts();

      if (data["success"]) {
        var dataJson = (data["data"]);
        List<Discount> itemsLocal = [];

        for (var i = 0; i < dataJson.length; i++) {
          Discount discount = Discount();
          discount.id = dataJson[i]["id"];
          discount.idOrg = dataJson[i]["idOrg"];
          discount.name = dataJson[i]["name"];
          discount.calculationType = dataJson[i]["calculationType"];
          discount.type = dataJson[i]["type"];
          discount.value = "${dataJson[i]["value"]}";
          discount.limitedAccess = dataJson[i]["limitedAccess"];

          itemsLocal.add(discount);
        }
        discounts.assignAll(itemsLocal);
      }
    } catch (e) {
      return false;
    }
  }
}
