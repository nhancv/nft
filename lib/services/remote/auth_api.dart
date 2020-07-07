import 'dart:convert';

import 'package:dio/dio.dart';

import 'api.dart';

class AuthApi extends Api {
  /// Login
  Future<Response<dynamic>> signIn() async {
    final Map<String, String> header = await getHeader();
    return wrapE(() => dio.post('https://nhancv.free.beeceptor.com/login',
        options: Options(headers: header),
        // ignore: always_specify_types
        data: json.encode({
          'username': 'username',
          'password': 'password',
        })));
  }

  /// Login With Error
  Future<Response<dynamic>> signInWithError() async {
    final Map<String, String> header = await getHeader();
    return wrapE(() => dio.post('https://nhancv.free.beeceptor.com/login-err',
        options: Options(headers: header),
        // ignore: always_specify_types
        data: json.encode({
          'username': 'username',
          'password': 'password',
        })));
  }
}
