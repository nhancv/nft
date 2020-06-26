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
  BuildContext _dialogContext;

  AppLoadingProvider();

  static void show(BuildContext context) {
    context.read<AppLoadingProvider>().showLoading(context);
  }

  static void hide(BuildContext context) {
    context.read<AppLoadingProvider>().hideLoading();
  }

  Future<void> showLoading(BuildContext context) async {
    hideLoading();
    await showDialog(
      context: context,
      builder: (dialogContext) {
        _dialogContext = dialogContext;
        return Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              child: SpinKitDoubleBounce(color: Colors.white),
              alignment: Alignment.center,
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
