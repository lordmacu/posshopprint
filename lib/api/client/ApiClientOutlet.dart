import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:posshop_app/model/dto/Outlet.dart';
import 'package:posshop_app/exceptions/FetchException.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Outlet> get() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString("token");

  if (token == null) {
    throw Exception('No autenticado');
  }

  final response = await http.get(
    Uri.parse('https://poschile.bbndev.com/api/outlets-disponibles'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.acceptHeader: 'application/json',
    },
  );
  debugPrint('Bearer $token');
  debugPrint(response.body);
  if (response.statusCode == 200) {
    return Outlet.fromJson(jsonDecode(response.body));
  } else {
    throw FetchException(jsonDecode(response.body)['message']);
  }
}
