// ignore: import_of_legacy_library_into_null_safe
import 'package:dio/dio.dart';

// part 'api_error_message_error.g.dart';

// @JsonSerializable()
class ApiErrorMessageError extends DioError {
  String? errorMessage;
  RequestOptions request;
  ApiErrorMessageError({required this.request, this.errorMessage})
      : super(requestOptions: request);
  /* // @JsonKey(name: 'error_message')
  final String? errorMessage;

  // @override
  // @JsonKey()
  final RequestOptions request;

  // @override
  // @JsonKey()
  final Response? response;

  // @override
  // @JsonKey()
  final DioErrorType type;

  // @override
  // @JsonKey()
  dynamic? error;

  ApiErrorMessageError({
    required this.errorMessage,
    required this.request,
    this.response,
    required this.type,
    this.error,
  }) : super(requestOptions: request);

  factory ApiErrorMessageError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorMessageErrorFromJson(json);*/
}
