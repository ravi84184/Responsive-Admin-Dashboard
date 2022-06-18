import 'package:dio/dio.dart';

import '../api_errors/unauthorized_api_error.dart';

class UnauthorizedInterceptor extends Interceptor {
  @override
  Future onError(DioError error, var handler) async {
    if (error.response?.statusCode == 401 ||
        error.response?.statusCode == 403) {
      return UnauthorizedApiError(request: error.requestOptions);
    }
    return null;
  }
}
