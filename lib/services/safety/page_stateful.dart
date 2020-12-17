import 'package:flutter/material.dart';
import 'package:nft/services/app/app_dialog.dart';
import 'package:nft/services/app/app_loading.dart';
import 'package:nft/services/app/auth_provider.dart';
import 'package:nft/services/app/locale_provider.dart';
import 'package:nft/services/rest_api/api_error.dart';
import 'package:nft/services/rest_api/api_error_type.dart';
import 'package:nft/services/safety/base_stateful.dart';
import 'package:nft/utils/app_route.dart';
import 'package:provider/provider.dart';

abstract class PageStateful<T extends StatefulWidget> extends BaseStateful<T>
    with ApiError {
  LocaleProvider localeProvider;
  AuthProvider authProvider;

  @mustCallSuper
  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    localeProvider = Provider.of(context, listen: false);
    authProvider = Provider.of(context, listen: false);
  }

  @override
  Future<void> onApiError(dynamic error) async {
    final ApiErrorType errorType = parseApiErrorType(error);
    await AppDialogProvider.show(context, errorType.message, title: 'Error');
    await Future<void>.delayed(const Duration(seconds: 1));
    if (errorType.code == ApiErrorCode.unauthorized) {
      logout(context);
    }
  }

  // Logout function
  Future<void> logout(BuildContext context) async {
    await apiCallSafety(
      authProvider.logout,
      onStart: () async {
        AppLoadingProvider.show(context);
      },
      onFinally: () async {
        AppLoadingProvider.hide(context);
        context.navigator()?.pushNamedAndRemoveUntil('/', (_) => false);
      },
      skipOnError: true,
    );
  }
}
