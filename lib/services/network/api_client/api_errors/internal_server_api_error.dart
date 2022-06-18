import 'package:dio/dio.dart';

class InternalServerApiError extends DioError {
  RequestOptions request;

  InternalServerApiError({required this.request})
      : super(requestOptions: request);
}
