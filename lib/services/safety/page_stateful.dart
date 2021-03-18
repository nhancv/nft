import 'package:flutter/material.dart';
import 'package:nft/services/app/app_dialog.dart';
import 'package:nft/services/app/app_loading.dart';
import 'package:nft/services/app/auth_provider.dart';
import 'package:nft/services/app/locale_provider.dart';
import 'package:nft/services/rest_api/api_error.dart';
import 'package:nft/services/rest_api/api_error_type.dart';
import 'package:nft/services/safety/base_stateful.dart';
import 'package:nft/utils/app_extension.dart';
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
  Future<int> onApiError(dynamic error) async {
    final ApiErrorType errorType = parseApiErrorType(error);
    if (errorType.message != null && errorType.message.isNotEmpty) {
      await AppDialog.show(context, errorType.message, title: 'Error');
    }
    if (errorType.code == ApiErrorCode.unauthorized) {
      await logout(context);
      return 1;
    }
    return 0;
  }

  /// Logout function
  Future<void> logout(BuildContext context) async {
    await apiCallSafety(
      authProvider.logout,
      onStart: () async {
        AppLoading.show(context);
      },
      onFinally: () async {
        AppLoading.hide(context);
        context
            .navigator()
            ?.pushNamedAndRemoveUntil(AppRoute.routeRoot, (_) => false);
      },
      skipOnError: true,
    );
  }
}
