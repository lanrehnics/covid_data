import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class NetworkUtilz {
  Dio dio = new Dio();

  Future<http.Response> post(String url, Map<String, dynamic> params) async {
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(params));
    return response;
  }

  Future<http.Response> get(String url) async {
    var response = await http.get(url);
    return response;
  }

  Future<http.Response> put(String url, Map<String, dynamic> params) async {
    var response = await http.put(url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(params));
    return response;
  }

  Future<Response> _connectToApi(String url, RequestVerb action,
      {useSystemLogOut = true,
      classTag = '',
      listParam,
      Map<String, dynamic> params}) async {
    Response response;
    dio = getDio();
    try {
      switch (action) {
        case RequestVerb.post:
          response = await dio.post(url, data: params ?? listParam);
          break;
        case RequestVerb.get:
          response = await dio.get(url);
          break;
      }
    } on DioError catch (e) {
      response = e.response ?? Response(statusCode: 400);
      switch (e.type) {
        case DioErrorType.CANCEL:
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          break;
        case DioErrorType.SEND_TIMEOUT:
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          break;
        case DioErrorType.DEFAULT:
          if (response.statusMessage == null ||
              response.statusMessage.isEmpty) {
            response.statusMessage =
                "oops an error occured when connecting to the server please try again later";
          }
          break;
        case DioErrorType.RESPONSE:
          break;
      }
    }
    return response;
  }

  Future<Response> dioPost(String url, Map<String, dynamic> params,
      {useSystemLogOut = true, classTag = '', listParam}) async {
    return await _connectToApi(url, RequestVerb.post,
        params: params, listParam: listParam, useSystemLogOut: useSystemLogOut);
  }

  Future<Response> dioGet(String url, {useSystemLogOut = true}) async {
    return await _connectToApi(url, RequestVerb.get,
        useSystemLogOut: useSystemLogOut);
  }

  Dio getDio() {
    Dio dio = new Dio(BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
    ));
    return dio;
  }
}

enum RequestVerb { post, get, put, delete, upload }
