import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:posshop_app/exceptions/FetchException.dart';
import 'package:posshop_app/model/dto/TaxesRequest.dart';
import '../../data/SPToken.dart';

Future<TaxesRequest> getAll(int idPos) async {
  String token = await SPToken.get();

  if (token == '') {
    throw Exception('No autenticado');
  }

  final response = await http.get(
    Uri.parse('https://poschile.bbndev.com/api/taxs-disponibles/?id_cashregister=$idPos'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.acceptHeader: 'application/json',
    },
  );
  if (response.statusCode == 200) {
    return TaxesRequest.fromJson(jsonDecode(response.body));
  } else {
    throw FetchException(jsonDecode(response.body)['message']);
  }
}
