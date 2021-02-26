import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nft/models/local/token.dart';
import 'package:nft/utils/app_config.dart';

class Api {
  Api() {
    if (!kReleaseMode) {
      dio.interceptors
          .add(LogInterceptor(responseBody: true, requestBody: true));
    }
  }

  /// Credential info
  Token token;

  /// Get base url by env
  final String apiBaseUrl = AppConfig.I.env.apiBaseUrl;
  final Dio dio = Dio();

  /// Get request header options
  Future<Options> getOptions(
      {String contentType = Headers.jsonContentType}) async {
    final Map<String, String> header = <String, String>{
      Headers.acceptHeader: 'application/json'
    };
    return Options(headers: header, contentType: contentType);
  }

  /// Get auth header options
  Future<Options> getAuthOptions({String contentType}) async {
    final Options options = await getOptions(contentType: contentType);

    if (token != null) {
      options.headers.addAll(
          <String, String>{'Authorization': 'Bearer ${token.accessToken}'});
    }

    return options;
  }

  /// Wrap Dio Exception
  Future<Response<T>> wrapE<T>(Future<Response<T>> Function() dioApi) async {
    try {
      return await dioApi();
    } catch (error) {
      if (error is DioError && error.type == DioErrorType.RESPONSE) {
        final Response<dynamic> response = error.response;

        try {
          /// By pass dio header error code to get response content
          /// Try to return response
          if (response != null) {
            final Response<T> res = Response<T>(
              data: response.data as T,
              headers: response.headers,
              request: response.request,
              isRedirect: response.isRedirect,
              statusCode: response.statusCode,
              statusMessage: response.statusMessage,
              redirects: response.redirects,
              extra: response.extra,
            );
            return res;
          }
        } catch (e) {
          print(e);
        }

        final String errorMessage =
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
