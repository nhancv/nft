
/*
{
    "error": true,
    "data": null,
    "errors": [
        {
            "code": 1029,
            "message": "User not found!."
        }
    ]
}
 */
import 'dart:core';

abstract class BaseResponse<T> {
  bool error;
  T data;
  List<BaseError> errors;

  BaseResponse(Map<String, dynamic> fullJson) {
    parsing(fullJson);
  }

  /// Abstract json to data
  T jsonToData(Map<String, dynamic> fullJson);
  /// Abstract data to json
  dynamic dataToJson(T data);

  /// Parsing data to object
  parsing(Map<String, dynamic> fullJson) {
    error = fullJson["error"] ?? false;
    data = jsonToData(fullJson);
    errors = parseErrorList(fullJson);
  }

  /// Parse error list from server
  List<BaseError> parseErrorList(Map<String, dynamic> fullJson) {
    List errors = fullJson["errors"];
    return errors != null
        ? List<BaseError>.from(errors.map((x) => BaseError.fromJson(x)))
        : <BaseError>[];
  }

  /// Data to json
  Map<String, dynamic> toJson() => {
    "error": error,
    "data": dataToJson(data),
    "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
  };
}

class BaseError {
  int code;
  String message;

  BaseError({
    this.code,
    this.message,
  });

  factory BaseError.fromJson(Map<String, dynamic> json) => BaseError(
    code: json["code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
  };
}
