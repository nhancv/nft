import 'package:dio/dio.dart';

import 'api.dart';

class AuthApi extends Api {
  /// Login
  Future<Response<Map<String, dynamic>>> logIn() async {
    final Map<String, String> header = await getHeader();
    return wrapE(() => dio.post<Map<String, dynamic>>('$apiBaseUrl/login',
            options: Options(headers: header),
            data: <String, String>{
              'username': 'username',
              'password': 'password',
            }));
  }

  /// Login With Error
  Future<Response<Map<String, dynamic>>> logInWithError() async {
    final Map<String, String> header = await getHeader();
    return wrapE(() => dio.post<Map<String, dynamic>>('$apiBaseUrl/login-err',
            options: Options(headers: header),
            data: <String, String>{
              'username': 'username',
              'password': 'password',
            }));
  }
}
