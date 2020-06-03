/*
Normal
{
    "data": any,
    "error": null
}
Error
{
    "data": null,
    "error": {
            "code": 1029,
            "message": "User not found!."
        }
}
 */
import 'dart:core';

abstract class BaseResponse<T> {
  T data;
  BaseError error;

  BaseResponse(Map<String, dynamic> fullJson) {
    parsing(fullJson);
  }

  /// Abstract json to data
  T jsonToData(Map<String, dynamic> dataJson);

  /// Abstract data to json
  dynamic dataToJson(T data);

  /// Parsing data to object
  parsing(Map<String, dynamic> fullJson) {
    if (fullJson != null) {
      data = fullJson["data"] != null ? jsonToData(fullJson["data"]) : null;
      error = fullJson["error"] != null
          ? BaseError.fromJson(fullJson["error"])
          : null;
    }
  }

  /// Data to json
  Map<String, dynamic> toJson() => {
        "data": data != null ? dataToJson(data) : null,
        "error": error?.toJson(),
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

// Example
//import 'base_response.dart';
//
//class Credential {
//  final String tokenType;
//  final int expiresIn;
//  final String accessToken;
//  final String refreshToken;
//
//  Credential(
//      {this.tokenType, this.expiresIn, this.accessToken, this.refreshToken});
//
//  factory Credential.fromJson(Map<String, dynamic> json) => Credential(
//    tokenType: json["token_type"],
//    expiresIn: json["expires_in"],
//    accessToken: json["access_token"],
//    refreshToken: json["refresh_token"],
//  );
//
//  Map<String, dynamic> toJson() => {
//    "tokenType": tokenType,
//    "expiresIn": expiresIn,
//    "accessToken": accessToken,
//    "refreshToken": refreshToken,
//  };
//}
//
//class LoginResponse extends BaseResponse<Credential> {
//  LoginResponse(Map<String, dynamic> fullJson) : super(fullJson);
//
//  @override
//  Map<String, dynamic> dataToJson(data) {
//    return data.toJson();
//  }
//
//  @override
//  jsonToData(Map<String, dynamic> dataJson) {
//    return Credential.fromJson(dataJson);
//  }
//}
