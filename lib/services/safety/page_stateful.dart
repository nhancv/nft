import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nft/services/apis/api_error.dart';
import 'package:nft/services/apis/api_error_type.dart';
import 'package:nft/services/app/app_route.dart';
import 'package:nft/services/providers/provider_auth.dart';
import 'package:nft/services/providers/provider_locale.dart';
import 'package:nft/services/providers/providers.dart';
import 'package:nft/services/safety/base_stateful.dart';
import 'package:nft/utils/app_dialog.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_loading.dart';

abstract class PageStateful<T extends ConsumerStatefulWidget> extends BaseStateful<T> with ApiError {
  late LocaleProvider localeProvider;
  late AuthProvider authProvider;

  @mustCallSuper
  @override
  void initDependencies(WidgetRef ref) {
    super.initDependencies(ref);
    localeProvider = ref.read(pLocaleProvider);
    authProvider = ref.read(pAuthProvider);
  }

  @override
  Future<int> onApiError(dynamic error) async {
    final ApiErrorType errorType = parseApiErrorType(error);
    if (errorType.message.isNotEmpty) {
      await AppDialog.show(ref, errorType.message, title: 'Error');
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
        AppLoading.show(ref);
      },
      onFinally: () async {
        AppLoading.hide(ref);
        ref.navigator()?.pushNamedAndRemoveUntil(AppRoute.routeRoot, (_) => false);
      },
      skipOnError: true,
    );
  }
}
