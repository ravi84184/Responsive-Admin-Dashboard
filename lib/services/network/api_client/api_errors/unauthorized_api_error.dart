import 'package:dio/dio.dart';

class UnauthorizedApiError extends DioError {
  RequestOptions request;

  UnauthorizedApiError({required this.request})
      : super(requestOptions: request);
}
