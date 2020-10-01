import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  bool requestClose = false;

  /// Show loading dialog shortcut
  static void show(BuildContext context) {
    context.read<AppLoadingProvider>().showLoading(context);
  }

  /// Hide loading dialog shortcut
  static void hide(BuildContext context) {
    context.read<AppLoadingProvider>().hideLoading();
  }

  /// Show loading dialog
  Future<void> showLoading(BuildContext context) async {
    hideLoading(isClean: true);
    showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        _dialogContext = dialogContext;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (requestClose) {
            hideLoading();
          }
        });
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

  /// Hide loading dialog
  void hideLoading({bool isClean = false}) {
    if (_dialogContext != null) {
      if (Navigator.canPop(_dialogContext)) {
        Navigator.pop(_dialogContext);
      }
      _dialogContext = null;
    }
    requestClose = !isClean;
  }
}
