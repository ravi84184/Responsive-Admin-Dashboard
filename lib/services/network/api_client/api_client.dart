import 'dart:convert';

import 'package:dio/dio.dart';

import 'api_errors/api_error_message_error.dart';
import 'api_errors/internal_server_api_error.dart';
import 'api_errors/unauthorized_api_error.dart';
import 'exceptions/exceptions.dart';
import 'interceptors/api_error_message_interceptor.dart';
import 'interceptors/internal_server_error_interceptor.dart';
import 'interceptors/unauthorized_interceptor.dart';
import 'model/common_response.dart';

/// api client in which main post get methods for api call is defined
class ApiClient {
  final Dio dio;

  ApiClient(this.dio) {
    dio.options.baseUrl = "https://book.apuzztech.com/duraplast/api/";
    dio.options.connectTimeout = const Duration(minutes: 3).inMilliseconds;
    dio.options.receiveTimeout = const Duration(minutes: 3).inMilliseconds;
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Charset': 'utf-8',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    };
    //TODO: need to fix
    // dio.interceptors.add(ApiErrorMessageInterceptor());
    // dio.interceptors.add(InternalServerErrorInterceptor());
    // dio.interceptors.add(UnauthorizedInterceptor());
    dio.interceptors.add(LogInterceptor(
      requestHeader: false,
      requestBody: true,
      responseHeader: false,
      responseBody: true,
      error: true,
    ));
    /*  if (Env.data.debugApiClient) {
      dio.interceptors.add(LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
      ));
    }*/
  }

  /// post method for api call
  Future<Response> post(
    String path, {
    required dynamic data,
    Function(int count, int total)? onSendProgress,
  }) async {
    try {
      return await dio.post(
        path,
        data: data,
        onSendProgress: onSendProgress ?? null,
        options: Options(
            headers: {'Content-Type': 'application/json', 'Charset': 'utf-8',
              "Access-Control-Allow-Origin": "*",
              "Access-Control-Allow-Credentials": "true",
              "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
              "Access-Control-Allow-Methods": "POST, OPTIONS"}),
      );
    } on InternalServerApiError {
      throw InternalServerException();
    } on UnauthorizedApiError {
      throw UnauthenticatedException();
    } on ApiErrorMessageError catch (e) {
      throw ApiErrorMessageException(errorMessage: e.errorMessage!);
    } on DioError catch (e) {
      throw ApiException(
          errorMessage: ApiErrorResponse.fromJson(
        json.decode(e.response?.data),
      ).error.message);
    }
  }

  /// put method for api call
  Future<Response> put(String path, dynamic data) async {
    try {
      return await dio.put(path, data: data,options: Options(
          headers: {'Content-Type': 'application/json', 'Charset': 'utf-8',
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Credentials": "true",
            "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"}),);
    } on InternalServerApiError {
      throw InternalServerException();
    } on UnauthorizedApiError {
      throw UnauthenticatedException();
    } on ApiErrorMessageError catch (e) {
      throw ApiErrorMessageException(errorMessage: e.errorMessage!);
    } on DioError catch (e) {
      throw ApiException(
          errorMessage: ApiErrorResponse.fromJson(
        json.decode(e.response?.data),
      ).error.message);
    }
  }

  /// delete method for api call
  Future<Response> delete(String path) async {
    try {
      return await dio.delete(path,options: Options(
          headers: {'Content-Type': 'application/json', 'Charset': 'utf-8',
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Credentials": "true",
            "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"}),);
    } on InternalServerApiError {
      throw InternalServerException();
    } on UnauthorizedApiError {
      throw UnauthenticatedException();
    } on ApiErrorMessageError catch (e) {
      throw ApiErrorMessageException(errorMessage: e.errorMessage!);
    } on DioError catch (e) {
      throw ApiException(
          errorMessage: ApiErrorResponse.fromJson(
        json.decode(e.response?.data),
      ).error.message);
    }
  }

  /// get method for api call
  Future<Response> get(
    String path, {
    dynamic data,
  }) async {
    try {
      return await dio.get(path, queryParameters: data,options: Options(
          headers: {'Content-Type': 'application/json', 'Charset': 'utf-8',
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Credentials": "true",
            "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
            "Access-Control-Allow-Methods": "POST, OPTIONS"}),);
    } on InternalServerApiError {
      throw InternalServerException();
    } on UnauthorizedApiError {
      throw UnauthenticatedException();
    } on ApiErrorMessageError catch (e) {
      throw ApiErrorMessageException(errorMessage: e.errorMessage!);
    } on DioError catch (e) {
      throw ApiException(
          errorMessage:
              ApiErrorResponse.fromJson(e.response?.data).error.message);
    }
  }
}

/// class used for api errors
class ApiErrorResponse extends CommonResponse {
  ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    this.error =
        (json['error'] != null ? Error.fromJson(json['error']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error.toJson();
    return data;
  }
}
