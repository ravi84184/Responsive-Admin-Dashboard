import 'package:dio/dio.dart';
import 'package:responsive_admin_dashboard/services/network/api_client/api_errors/api_error_message_error.dart';
import 'package:responsive_admin_dashboard/services/network/api_client/model/general_response.dart';

class ApiErrorMessageInterceptor extends Interceptor {
  @override
  Future<dynamic> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    if (response != null) {
      if (response.data != null) {
        final error = GeneralResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        if (error.error.message != null) {
          ApiErrorMessageError(
              request: response.requestOptions,
              errorMessage: error.error.message);
          return error;
        }
      }
    }

    return null;
  }
}
