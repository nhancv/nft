/*
Error
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

Successful
{
    "token_type": "Bearer",
    "expires_in": 1295998,
    "access_token": "nhancv_dep_trai",
    "refresh_token": "call_nhancv_dep_trai"
}
 */

import 'base_response.dart';

class Credential {
  final String tokenType;
  final int expiresIn;
  final String accessToken;
  final String refreshToken;

  Credential(
      {this.tokenType, this.expiresIn, this.accessToken, this.refreshToken});

  factory Credential.fromJson(Map<String, dynamic> json) => Credential(
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "tokenType": tokenType,
        "expiresIn": expiresIn,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}

class LoginResponse extends BaseResponse<Credential> {
  LoginResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  Map<String, dynamic> dataToJson(data) {
    return data.toJson();
  }

  @override
  jsonToData(Map<String, dynamic> dataJson) {
    return Credential.fromJson(dataJson);
  }
}
