import 'dart:async';
import "package:dio/dio.dart";

class Client{
  Dio init() {
    Dio _dio = new Dio();
    _dio.interceptors.add(new ApiInterceptors());
    _dio.options.baseUrl = "https://poschile.bbndev.com/api";
    return _dio;
  }
}

class ApiInterceptors extends Interceptor {
  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    // do something before request is sent

    print(options.baseUrl);
    print(options.data);
  }

  @override
  Future<dynamic> onError(DioError dioError) async  {
    print("erro : ${dioError.response}");
    throw new Exception(dioError.response);
  }

  @override
  Future<dynamic> onResponse(Response response) async {
    // do something before response
    print("ok : ${response}");

  }
}