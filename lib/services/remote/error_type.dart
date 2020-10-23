enum ErrorCode { unknown, unauthorized }

class ErrorType {
  ErrorType({this.code = ErrorCode.unknown, this.message = 'Unknown'});

  final ErrorCode code;
  final String message;
}
