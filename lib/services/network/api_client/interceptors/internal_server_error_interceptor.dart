import 'package:dio/dio.dart';

import '../api_errors/internal_server_api_error.dart';

class InternalServerErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError error, var handler) async {
    if (error.response != null) {
      if (error.response!.statusCode! >= 500 &&
          error.response!.statusCode! < 600) {
        return InternalServerApiError(request: error.requestOptions);
      }
    }

    return null;
  }
}
