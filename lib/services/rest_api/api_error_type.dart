enum ApiErrorCode { unknown, unauthorized }

class ApiErrorType {
  ApiErrorType({this.code = ApiErrorCode.unknown, this.message = 'Unknown'});

  final ApiErrorCode code;
  final String message;

  @override
  String toString() {
    return 'ApiErrorType{code: $code, message: $message}';
  }
}
