import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:posshop_app/api/exceptions/FetchDataException.dart';
import '../../model/dto/LoginRequest.dart';

Future<LoginRequest> post(String email, String password) async {
  final response = await http.post(
    Uri.parse(
        'https://poschile.bbndev.com/api/auth/login?email=$email&password=$password'),
    headers: {
      HttpHeaders.acceptHeader: 'application/json',
    },
  );
  if (response.statusCode == 200) {
    return LoginRequest.fromJson(jsonDecode(response.body));
  } else {
    throw FetchDataException(jsonDecode(response.body)['message']);
  }
}
