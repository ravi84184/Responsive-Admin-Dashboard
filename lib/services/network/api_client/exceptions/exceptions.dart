class CacheException implements Exception {}

class ApiException implements Exception {
  final String errorMessage;

  ApiException({required this.errorMessage});
}

class BadNetworkException implements Exception {}

class InternalServerException implements Exception {}

class UnauthenticatedException implements Exception {}

class ApiErrorMessageException implements Exception {
  final String errorMessage;

  ApiErrorMessageException({required this.errorMessage});
}
