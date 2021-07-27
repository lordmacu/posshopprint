import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:posshop_app/api/exceptions/BadRequestException.dart';
import 'package:posshop_app/api/exceptions/ConnectionException.dart';
import 'package:posshop_app/api/exceptions/FetchDataException.dart';
import 'package:posshop_app/api/exceptions/NotFoundException.dart';
import 'package:posshop_app/api/exceptions/UnauthorisedException.dart';
import 'package:posshop_app/data/SPToken.dart';

class APIManager {
  String _token = "";

  Future<dynamic> post(String url, {Map param = const <String, String>{}}) async {
    await loadToken();
    print("Calling post API: $url");
    print("Calling parameters: $param");

    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        body: param,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $_token',
          HttpHeaders.acceptHeader: 'application/json',
        },
      );
      responseJson = _response(response);
    } on Exception catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw ConnectionException(e.toString());
      } else {
        rethrow;
      }
    }
    return responseJson;
  }

  Future<dynamic> get(String url) async {
    await loadToken();
    print("Calling get API: $url");

    var responseJson;
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $_token',
          HttpHeaders.acceptHeader: 'application/json',
        },
      );
      responseJson = _response(response);
    } on Exception catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw ConnectionException(e.toString());
      } else {
        rethrow;
      }
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    await loadToken();
    print("Calling delete API: $url");

    var responseJson;
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $_token',
          HttpHeaders.acceptHeader: 'application/json',
        },
      );
      responseJson = _response(response);
    } on Exception catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw ConnectionException(e.toString());
      } else {
        rethrow;
      }
    }
    return responseJson;
  }

  Future<dynamic> put(String url) async {
    await loadToken();
    print("Calling put API: $url");

    var responseJson;
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $_token',
          HttpHeaders.acceptHeader: 'application/json',
        },
      );
      responseJson = _response(response);
    } on Exception catch (e) {
      if (e is SocketException || e is TimeoutException) {
        throw ConnectionException(e.toString());
      } else {
        rethrow;
      }
    }
    return responseJson;
  }

  loadToken() async {
    _token = await SPToken.get();

    if (_token == '') {
      throw Exception('No autenticado');
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body);
      case 401:
      case 403:
        throw UnauthorisedException(response.body);
      case 404:
        throw NotFoundException(response.body);
      case 500:
      default:
        throw FetchDataException('Error occurred while communication with server, with StatusCode: ${response.statusCode}');
    }
  }
}
