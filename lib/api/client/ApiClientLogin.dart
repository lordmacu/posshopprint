import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../model/dto/LoginRequest.dart';
import '../../exceptions/FetchException.dart';

Future<LoginRequest> post(String email, String password) async {
  final response = await http.post(
    Uri.parse(
        'https://poschile.bbndev.com/api/auth/login?email=$email&password=$password'),
    headers: {
      //HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
      HttpHeaders.acceptHeader: 'application/json',
    },
  );
  debugPrint(response.body);
  if (response.statusCode == 200) {
    return LoginRequest.fromJson(jsonDecode(response.body));
  } else {
    throw FetchException(jsonDecode(response.body)['message']);
  }
}
