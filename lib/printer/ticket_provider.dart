import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class TicketProvider {
  Dio _client;

  TicketProvider(this._client);
  SharedPreferences prefs;

  Future getTickets() async {
    prefs = await SharedPreferences.getInstance();

    var outletId="${prefs.getInt("outletId")}";
    print("este es el outlet Id  ${outletId}");
    try {

      final response = await _client.get(
          '/tickets?cashregister_id=${prefs.getInt("cashierId")}');

      return json.decode(response.toString());
    } on DioError catch (ex) {
        String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }





}
