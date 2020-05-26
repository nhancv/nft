
import 'dart:convert';
import 'package:dio/dio.dart';
import 'api.dart';

class AuthApi extends Api {
  /// Login
  Future<Response> signIn() async {
    final header = await getHeader();
    return wrapE(() => dio.post("https://nhancv.free.beeceptor.com/login",
        options: Options(headers: header),
        data: json.encode({
          "username": "username",
          "password": "password",
        })));
  }

  /// Login With Error
  Future<Response> signInWithError() async {
    final header = await getHeader();
    return wrapE(() => dio.post("https://nhancv.free.beeceptor.com/login-err",
        options: Options(headers: header),
        data: json.encode({
          "username": "username",
          "password": "password",
        })));
  }
}
