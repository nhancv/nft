import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:nft/utils/app_config.dart';

mixin ApiError {
  /// This function was called when trigger safeCallApi
  /// and apiError = true as default
  Future<void> onApiError(dynamic error);

  /// Call api safety with error handling.
  /// Required:
  /// - dioApi: call async dio function
  /// Optional:
  /// - onStart: the function executed before api, can be null
  /// - onError: the function executed in case api crashed, can be null
  /// - onCompleted: the function executed after api or before crashing, can be null
  /// - onFinally: the function executed end of function, can be null
  /// - apiError: true as default if you want to forward the error to onApiError
  Future<T> safeCallApi<T>(
    Future<T> Function() dioApi, {
    Future<void> Function() onStart,
    Future<void> Function(dynamic error) onError,
    Future<void> Function() onCompleted,
    Future<void> Function() onFinally,
    bool apiError = true,
  }) async {
    try {
      // On start, use for show loading
      if (onStart != null) {
        await onStart();
      }

      // Execute api
      final T res = await dioApi();

      // On completed, use for hide loading
      if (onCompleted != null) {
        await onCompleted();
      }
      // Return api response
      return res;
    } catch (error) {
      // In case error:
      // On completed, use for hide loading
      if (onCompleted != null) {
        await onCompleted();
      }

      // On inline error
      if (onError != null) {
        await onError(error);
      }

      // Call onApiError if apiError's enabled
      if (apiError) {
        onApiError(error);
      }

      return null;
    } finally {
      // Call finally function
      if (onFinally != null) {
        await onFinally();
      }
    }
  }
}
