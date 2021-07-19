import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:posshop_app/exceptions/NotFoundException.dart';
import 'package:posshop_app/model/dto/CategoriesRequest.dart';
import 'package:posshop_app/exceptions/FetchException.dart';
import 'package:posshop_app/model/dto/CategoryRequest.dart';
import '../../data/SPToken.dart';

Future<CategoriesRequest> getAll() async {
  String token = await SPToken.get();

  if (token == '') {
    throw Exception('No autenticado');
  }

  final response = await http.get(
    Uri.parse('https://poschile.bbndev.com/api/category'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.acceptHeader: 'application/json',
    },
  );
  if (response.statusCode == 200) {
    return CategoriesRequest.fromJson(jsonDecode(response.body));
  } else {
    throw FetchException(jsonDecode(response.body)['message']);
  }
}

Future<CategoryRequest> getById(int id) async {
  String token = await SPToken.get();

  if (token == '') {
    throw Exception('No autenticado');
  }

  final response = await http.get(
    Uri.parse('https://poschile.bbndev.com/api/category/$id'),
    headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.acceptHeader: 'application/json',
    },
  );
  if (response.statusCode == 200) {
    return CategoryRequest.fromJsonData(jsonDecode(response.body));
  } else if (response.statusCode == 404) {
    throw NotFoundException(jsonDecode(response.body)['message']);
  } else {
    throw FetchException(jsonDecode(response.body)['message']);
  }
}

Future<void> deleteById(int id) async {
  String token = await SPToken.get();

  if (token == '') {
    throw Exception('No autenticado');
  }

  final response = await http.delete(
    Uri.parse('https://poschile.bbndev.com/api/category/$id'),
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
