import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:posshop_app/exceptions/FetchException.dart';
import 'package:posshop_app/exceptions/NotFoundException.dart';
import 'package:posshop_app/model/dto/DiscountRequest.dart';
import 'package:posshop_app/model/dto/DiscountsRequest.dart';
import 'package:posshop_app/model/entity/DiscountEntity.dart';
import '../../data/SPToken.dart';

Future<DiscountsRequest> getAll(int idPos) async {
  String token = await SPToken.get();
  if (token == '') {
    throw Exception('No autenticado');
  }

  final response = await http.get(
    Uri.parse('https://poschile.bbndev.com/api/discount/?id_cashregister=$idPos'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.acceptHeader: 'application/json',
    },
  );
  if (response.statusCode == 200) {
    return DiscountsRequest.fromJson(jsonDecode(response.body));
  } else {
    throw FetchException(jsonDecode(response.body)['message']);
  }
}

Future<DiscountRequest> create(int idPos, DiscountEntity entity) async {
  String token = await SPToken.get();
  if (token == '') {
    throw Exception('No autenticado');
  }

  final response = await http.post(
    Uri.parse(
        'https://poschile.bbndev.com/api/discount?id_cashregister=$idPos&name=${entity.name}&calculationType=${entity.calculationType}${entity.value != null ? '&value=' + entity.value.toString().replaceAll(',', '.') : ''}'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.acceptHeader: 'application/json',
    },
  );
  if (response.statusCode == 200) {
    return DiscountRequest.fromJsonData(jsonDecode(response.body));
  } else {
    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    throw FetchException(jsonDecode(response.body)['message']);
  }
}

Future<DiscountRequest> update(DiscountEntity entity) async {
  String token = await SPToken.get();
  if (token == '') {
    throw Exception('No autenticado');
  }

  debugPrint(
      'https://poschile.bbndev.com/api/discount/${entity.idCloud}?name=${entity.name}&calculationType=${entity.calculationType}${entity.value != null ? '&value=' + entity.value.toString().replaceAll(',', '.') : ''}');

  final response = await http.put(
    Uri.parse(
        'https://poschile.bbndev.com/api/discount/${entity.idCloud}?name=${entity.name}&calculationType=${entity.calculationType}${entity.value != null ? '&value=' + entity.value.toString().replaceAll(',', '.') : ''}'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.acceptHeader: 'application/json',
    },
  );
  if (response.statusCode == 200) {
    return DiscountRequest.fromJsonData(jsonDecode(response.body));
  } else if (response.statusCode == 404) {
    throw NotFoundException(jsonDecode(response.body)['message']);
  } else {
    throw FetchException(jsonDecode(response.body)['message']);
  }
}

Future<void> delete(int id) async {
  String token = await SPToken.get();
  if (token == '') {
    throw Exception('No autenticado');
  }

  final response = await http.delete(
    Uri.parse('https://poschile.bbndev.com/api/discount/$id'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.acceptHeader: 'application/json',
    },
  );
  if (response.statusCode == 200) {
    return;
  } else if (response.statusCode == 404) {
    throw NotFoundException(jsonDecode(response.body)['message']);
  } else {
    throw FetchException(jsonDecode(response.body)['message']);
  }
}
