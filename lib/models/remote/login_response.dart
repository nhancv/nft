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

import 'package:nft/models/local/token.dart';
import 'package:nft/utils/app_log.dart';

import 'base_response.dart';

class LoginResponse extends BaseResponse<Token> {
  LoginResponse(Map<String, dynamic> fullJson) : super(fullJson);

  @override
  Map<String, dynamic> dataToJson(Token data) {
    return data.toJson();
  }

  @override
  Token jsonToData(dynamic dataJson) {
    try {
      return Token.fromJson(dataJson as Map<String, dynamic>);
    } catch (e) {
      logger.e('LoginResponse:jsonToData: $e');
    }
    return null;
  }
}
