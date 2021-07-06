import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:posshop_app/model/dto/OutletRequest.dart';
import 'package:posshop_app/exceptions/FetchException.dart';
import '../../data/SPToken.dart';

Future<OutletRequest> get() async {
  String token = await SPToken.get();

  if (token == '') {
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
    return OutletRequest.fromJson(jsonDecode(response.body));
  } else {
    throw FetchException(jsonDecode(response.body)['message']);
  }
}
