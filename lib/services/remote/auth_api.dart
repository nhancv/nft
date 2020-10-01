import 'package:dio/dio.dart';

import 'api.dart';

class AuthApi extends Api {
  /// Login
  Future<Response<dynamic>> signIn() async {
    final Map<String, String> header = await getHeader();
    return wrapE(() => dio.post<dynamic>('$apiBaseUrl/login',
            options: Options(headers: header),
            data: <String, String>{
              'username': 'username',
              'password': 'password',
            }));
  }

  /// Login With Error
  Future<Response<dynamic>> signInWithError() async {
    final Map<String, String> header = await getHeader();
    return wrapE(() => dio.post<dynamic>('$apiBaseUrl/login-err',
            options: Options(headers: header),
            data: <String, String>{
              'username': 'username',
              'password': 'password',
            }));
  }
}
