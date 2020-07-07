import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../utils/app_config.dart';

class Api {
  Api() {
    if (!kReleaseMode) {
      dio.interceptors.add(LogInterceptor());
    }
  }

  // Get base url by env
  final String apiBaseUrl = Config.instance.env.apiBaseUrl;
  final Dio dio = Dio();

  // Get header
  Future<Map<String, String>> getHeader() async {
    final Map<String, String> header = <String, String>{
      'content-type': 'application/json'
    };
    return header;
  }

  // Get header
  Future<Map<String, String>> getAuthHeader() async {
    final Map<String, String> header = await getHeader();

    header.addAll(<String, String>{'CUSTOM-HEADER-KEY': 'CUSTOM-HEADER-KEY'});

    return header;
  }

  // Wrap Dio Exception
  Future<Response<dynamic>> wrapE(
      Future<Response<dynamic>> Function() dioApi) async {
    try {
      return dioApi();
    } catch (error) {
      String errorMessage = error.toString();
      if (error is DioError && error.type == DioErrorType.RESPONSE) {
        final Response<dynamic> response = error.response;
        errorMessage =
            'Code ${response.statusCode} - ${response.statusMessage} ${response.data != null ? '\n' : ''} ${response.data}';
        throw DioError(
            request: error.request,
            response: error.response,
            type: error.type,
            error: errorMessage);
      }
      rethrow;
    }
  }
}
