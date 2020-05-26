
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

class LoginResponse extends BaseResponse {
  String tokenType;
  int expiresIn;
  String accessToken;
  String refreshToken;

  LoginResponse(Map<String, dynamic> fullJson) : super(fullJson) {
    tokenType= fullJson["token_type"];
    expiresIn= fullJson["expires_in"];
    accessToken= fullJson["access_token"];
    refreshToken= fullJson["refresh_token"];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "token_type": tokenType,
      "expires_in": expiresIn,
      "access_token": accessToken,
      "refresh_token": refreshToken,
      ... super.toJson()
    };
  }

  @override
  Map<String, dynamic> dataToJson(data) {
    return null;
  }

  @override
  jsonToData(Map<String, dynamic> fullJson) {
    return null;
  }
}
