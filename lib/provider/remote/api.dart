/*
 * MIT License
 *
 * Copyright (c) 2020 Nhan Cao
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nft/provider/global.dart';


class Api {
  // Get base url by env
  final String apiBaseUrl = Global.instance.env.apiBaseUrl;
  final Dio dio = new Dio();

  Api() {
    if (!kReleaseMode) {
      dio.interceptors.add(LogInterceptor(responseBody: false));
    }
  }

  // Get header
  Future<Map<String, String>> getHeader() async {
    Map<String, String> header = {'content-type': 'application/json'};
    return header;
  }

  // Get header
  Future<Map<String, String>> getAuthHeader() async {
    Map<String, String> header = await getHeader();

    header.addAll({"CUSTOM-HEADER-KEY": "CUSTOM-HEADER-KEY"});

    return header;
  }

  // Wrap Dio Exception
  Future<Response<dynamic>> wrapE(Function() dioApi) async {
    try {
      return await dioApi();
    } catch (error) {
      var errorMessage = error.toString();
      if (error is DioError && error.type == DioErrorType.RESPONSE) {
        final response = error.response;
        errorMessage =
            'Code ${response.statusCode} - ${response.statusMessage} ${response.data != null ? '\n' : ''} ${response.data}';
        throw new DioError(
            request: error.request,
            response: error.response,
            type: error.type,
            error: errorMessage);
      }
      throw error;
    }
  }
}
