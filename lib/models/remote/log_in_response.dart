/*
Error
{
	"data": null,
	"error": {
		"code": 1029,
		"message": "User not found!."
	}
}

Successful
{
	"data": {
		"token_type": "Bearer",
		"expires_in": 1295998,
		"access_token": "nhancv_dep_trai",
		"refresh_token": "call_nhancv_dep_trai"
	}
}
 */

import 'base_response.dart';

class Credential {
  Credential(
      {this.tokenType, this.expiresIn, this.accessToken, this.refreshToken});

  factory Credential.fromJson(Map<String, dynamic> json) => Credential(
        tokenType: json['token_type'] as String,
        expiresIn: json['expires_in'] as int,
        accessToken: json['access_token'] as String,
        refreshToken: json['refresh_token'] as String,
      );

  final String tokenType;
  final int expiresIn;
  final String accessToken;
  final String refreshToken;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tokenType': tokenType,
        'expiresIn': expiresIn,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
}

class LoginResponse extends BaseResponse<Credential> {
  LoginResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  Map<String, dynamic> dataToJson(Credential data) {
    return data.toJson();
  }

  @override
  Credential jsonToData(Map<String, dynamic> dataJson) {
    return Credential.fromJson(dataJson);
  }
}
