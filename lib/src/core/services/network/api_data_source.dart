import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ezy_pod/src/core/services/network/app_exceptions.dart';
import 'package:flutter/foundation.dart';

class NetworkApi {
  static NetworkApi? _instance;
  static final Dio _dio = Dio();

  static Map<String, dynamic> get header {
    return {"Auth-Token": "StaticInfo.authToken"};
  }

  NetworkApi._();

  static NetworkApi get instance {
    _instance ??= NetworkApi._();
    return _instance!;
  }

  Future get({
    required String url,
    Map<String, dynamic>? params,
    Map<String, dynamic>? customHeader,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: params,
        options: Options(
          headers: customHeader ?? header,
          sendTimeout: const Duration(milliseconds: 12000), //_defaultTimeout,
          receiveTimeout:
              const Duration(milliseconds: 12000), //_defaultTimeout,
        ),
      );

      return returnResponse(response);
    } on DioException catch (e) {
      throw DioExceptionError(_getDioExceptionErrorMessage(e.type));
    }
  }

  Future post({
    required String url,
    required Map<String, dynamic> body,
    Map<String, dynamic>? customHeader,
    List<MapEntry<String, File>>? files,
  }) async {
    Response<dynamic> response;
    try {
      dynamic data;
      if (files != null && files.isNotEmpty) {
        FormData formData = FormData();
        body.forEach((key, value) {
          formData.fields.add(MapEntry(key, value.toString()));
        });

        for (var fileEntry in files) {
          String fileName = fileEntry.value.path.split('/').last;
          formData.files.add(
            MapEntry(
              fileEntry.key,
              await MultipartFile.fromFile(fileEntry.value.path,
                  filename: fileName),
            ),
          );
        }
        data = formData;
      } else {
        data = body;
      }

      response = await _dio.post(
        url,
        data: data,
        options: Options(
          sendTimeout: const Duration(milliseconds: 12000),
          receiveTimeout: const Duration(milliseconds: 12000),
          headers: customHeader ?? header,
        ),
      );

      return returnResponse(response);
    } on DioException catch (e) {
      throw DioExceptionError(_getDioExceptionErrorMessage(e.type));
    }
  }

  String _getDioExceptionErrorMessage(DioExceptionType type) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timed out";
      case DioExceptionType.receiveTimeout:
        return "Receive timed out";
      case DioExceptionType.sendTimeout:
        return "Send timed out";
      case DioExceptionType.cancel:
        return "Request cancelled";
      case DioExceptionType.badCertificate:
        return "Invalid certificate";
      case DioExceptionType.badResponse:
        return "Bad response";
      case DioExceptionType.connectionError:
        return "Connection error";
      case DioExceptionType.unknown:
        return "Unknown error";
      default:
        return "Unknown error";
    }
  }

  dynamic returnResponse(Response<dynamic> response) {
    if (kDebugMode) {
      log("Status Code: ${response.statusCode}, Response: ${response.data}");
    }
    switch (response.statusCode) {
      case 200:
      case 201:
        dynamic jsonResponse = response.data;
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
