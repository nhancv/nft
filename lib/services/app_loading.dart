import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

/// *
/// Install:
/// Declare provider to my_app
/// Provider(create: (_) => AppLoadingProvider()),
///
/// Usage:
/// context.read<AppLoadingProvider>().showLoading(context);
/// or
/// AppLoadingProvider.show(context);
///
/// context.read<AppLoadingProvider>().hideLoading();
/// or
/// AppLoadingProvider.hide(context);
///
class AppLoadingProvider {
  AppLoadingProvider();

  BuildContext _dialogContext;

  static void show(BuildContext context) {
    context.read<AppLoadingProvider>().showLoading(context);
  }

  static void hide(BuildContext context) {
    context.read<AppLoadingProvider>().hideLoading();
  }

  Future<void> showLoading(BuildContext context) async {
    hideLoading();
    await showDialog<dynamic>(
      context: context,
      builder: (BuildContext dialogContext) {
        _dialogContext = dialogContext;
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              alignment: Alignment.center,
              child: const SpinKitDoubleBounce(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  void hideLoading() {
    if (_dialogContext != null) {
      Navigator.pop(_dialogContext);
      _dialogContext = null;
    }
  }
}
