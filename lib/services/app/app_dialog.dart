import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

/// *
/// Install:
/// Declare provider to my_app
/// Provider(create: (_) => AppDialogProvider()),
///
/// Usage:
/// context.read<AppDialogProvider>().showAppDialog(context);
/// or
/// AppDialogProvider.show(context);
///
/// context.read<AppDialogProvider>().hideAppDialog();
/// or
/// AppDialogProvider.hide(context);
///
class AppDialogProvider {
  AppDialogProvider();

  BuildContext _dialogContext;
  bool requestClose = false;

  /// Show alert dialog shortcut
  static Future<void> show(BuildContext context, String content,
      {String title}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return context
        .read<AppDialogProvider>()
        .showAppDialog(context, content, title: title);
  }

  /// Hide alert dialog shortcut
  static void hide(BuildContext context) {
    context.read<AppDialogProvider>().hideAppDialog();
  }

  /// Show alert dialog
  Future<void> showAppDialog(BuildContext context, String content,
      {String title}) async {
    hideAppDialog(isClean: true);
    showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        _dialogContext = dialogContext;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (requestClose) {
            hideAppDialog();
          }
        });
        return CupertinoAlertDialog(
          title: Text(title ?? 'Alert'),
          content: SingleChildScrollView(
            child: SelectableText(content ?? ''),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                hideAppDialog();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  /// Hide alert dialog
  void hideAppDialog({bool isClean = false}) {
    if (_dialogContext != null) {
      try {
        if (Navigator.canPop(_dialogContext)) {
          Navigator.pop(_dialogContext);
        }
      } catch (e) {
        // Unhandled Exception: Looking up a deactivated widget's ancestor is unsafe.
      }
      _dialogContext = null;
    }
    requestClose = !isClean;
  }
}
