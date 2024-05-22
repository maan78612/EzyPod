import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ezy_pod/src/core/services/network/app_exceptions.dart';
import 'package:flutter/foundation.dart';

class NetworkApi   {
  static NetworkApi? _instance;
  static final Dio _dio = Dio();

  NetworkApi._();

  static NetworkApi get instance {
    _instance ??= NetworkApi._();
    return _instance!;
  }


  Future get({
    required String url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? header,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: params,
        options: Options(
          // headers: header,
          sendTimeout: const Duration(milliseconds: 12000), //_defaultTimeout,
          receiveTimeout:
          const Duration(milliseconds: 12000), //_defaultTimeout,
        ),
      );

      return returnResponse(response);
    } on DioException {
      throw FetchDataException("Dio Error");
    } on IOException {
      throw FetchDataException("No Internet connection");
    }
  }


  Future post({
    required String url,
    required Map<String, dynamic> body,
    Map<String, dynamic>? header,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(
          sendTimeout: const Duration(milliseconds: 12000), //_defaultTimeout,
          receiveTimeout:
          const Duration(milliseconds: 12000), //_defaultTimeout,
          // headers: header,
        ),
      );
      return returnResponse(response);
    } on DioException {
      throw FetchDataException("No Internet connection");
    } on IOException {
      throw FetchDataException("No Internet connection");
    }
  }

  /// return valid response or throw exception on basis of status codes
  // dynamic returnResponse(http.Response response) {
  dynamic returnResponse(Response response) {
    if (kDebugMode) {
      log("Status Code: ${response.statusCode}, Response: ${response.data["data"]},"
          "Reason: ${response.data["message"]}");
    }
    switch (response.statusCode) {
      case 200:
      case 201:
        dynamic jsonResponse = response.data["data"];
        return jsonResponse;
      case 404:
        throw BadRequestException(response.statusMessage);
      case 443:
      case 500:
        throw InternalServerError(jsonDecode(response.data)['error']);
      case 400:
        {
          dynamic jsonResponse = jsonDecode(response.data);
          throw InvalidInputException(jsonResponse['error']);
        }
      default:
        throw FetchDataException(response.statusMessage);
    }
  }
}