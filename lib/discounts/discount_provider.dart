import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class DiscountProvider {
  Dio _client;

  DiscountProvider(this._client);
  SharedPreferences prefs;

  Future getDiscounts() async {
    prefs = await SharedPreferences.getInstance();

    var outletId="${prefs.getInt("outletId")}";
     try {

      final response = await _client.get(
          '/discounts');

      return json.decode(response.toString());
    } on DioError catch (ex) {
        String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

  Future createDiscount(data) async {
    prefs = await SharedPreferences.getInstance();

    var outletId="${prefs.getInt("outletId")}";
    try {

      final response = await _client.post(
          '/discounts',data:data);

      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

  Future editDiscount(data) async {
    prefs = await SharedPreferences.getInstance();

    var outletId="${prefs.getInt("outletId")}";
    try {

      final response = await _client.put(
          '/discounts/${data["id"]}',data:data);

      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

  Future deleteDiscount(data) async {
    prefs = await SharedPreferences.getInstance();

    var outletId="${prefs.getInt("outletId")}";
    try {

      final response = await _client.delete(
          '/discounts/${data["id"]}');

      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }




}
