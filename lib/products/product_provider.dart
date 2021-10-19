import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ProductProvider {
  Dio _client;

  ProductProvider(this._client);
  SharedPreferences prefs;

  Future getProducts() async {
    prefs = await SharedPreferences.getInstance();

    var outletId="${prefs.getInt("outletId")}";
    print("este es el outlet Id  ${outletId}");
    try {

      final response = await _client.get(
          '/items?devMode=true&itemsPerPage=20&page=1');

      return json.decode(response.toString());
    } on DioError catch (ex) {
        String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

  Future updateProduct(product,id) async {
    prefs = await SharedPreferences.getInstance();

    var outletId="${prefs.getInt("outletId")}";

    try {

      final response = await _client.put(
          '/items/${id}',data: product);

      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }

  Future<Response> sendForm(
      String url, Map<String, dynamic> data, Map<String, File> files) async {
    Map<String, MultipartFile> fileMap = {};
    for (MapEntry fileEntry in files.entries) {
      File file = fileEntry.value;
      String fileName = basename(file.path);
      fileMap[fileEntry.key] =
          MultipartFile(file.openRead(), await file.length(), filename: fileName);
    }
    data.addAll(fileMap);
    var formData = FormData.fromMap(data);
    Dio dio = new Dio();
    return await dio.post(url,
        data: formData, options: Options(contentType: 'multipart/form-data'));
  }

  Future<Response> sendFile(String url, File file) async {
    Dio dio = new Dio();
    var len = await file.length();
    var response = await dio.post(url,
        data: file.openRead(),
        options: Options(headers: {
          Headers.contentLengthHeader: len,
        } // set content-length
        ));
    return response;
  }

  Future uploadImage(image) async{
    prefs = await SharedPreferences.getInstance();

    var request = http.MultipartRequest("POST", Uri.parse("${prefs.getString("url")}/file-upload"));

    var pic = await http.MultipartFile.fromPath("file", image);

    request.files.add(pic);

    request.headers.addAll({"Authorization":"Bearer "+prefs.getString("token")});
    request.headers.addAll({"Accept":"application/json"});
    request.headers.addAll({"Content-Type":"application/json"});
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);

    return responseString;
  }

  Future createProduct(product) async {
    prefs = await SharedPreferences.getInstance();

    var outletId="${prefs.getInt("outletId")}";
    print("este es el outlet Id  ${outletId}");
    try {
      final response = await _client.post(
          '/items',data: product);

      return json.decode(response.toString());
    } on DioError catch (ex) {
      String errorMessage = ex.message.toString();
      throw new Exception(errorMessage);
    }
  }




}
