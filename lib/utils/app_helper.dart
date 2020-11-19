import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppHelper {
  /// Show popup
  static void showPopup(
    BuildContext context,
    Widget Function(BuildContext context) builder, {
    bool barrierDismissible = false,
  }) {
    showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      builder: builder,
    );
  }

  // Show snack bar
  static void showFlushBar(BuildContext context, String message) {
    Flushbar<void>(
            message: message,
            duration: const Duration(milliseconds: 2000),
            flushbarStyle: FlushbarStyle.GROUNDED)
        .show(context);
  }

  // Show toast
  static void showToast(
    String msg, {
    Toast toastLength,
    int timeInSecForIosWeb,
    Color backgroundColor,
  }) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: toastLength ?? Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: timeInSecForIosWeb ?? 1,
        backgroundColor: backgroundColor ?? Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  /// blocks rotation; sets orientation to: portrait
  static Future<void> portraitModeOnly() {
    return SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }

  /// blocks rotation; sets orientation to: landscape
  static Future<void> landscapeModeOnly() {
    return SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    );
  }

  /// Enable rotation
  static Future<void> enableRotation() {
    return SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
    );
  }
}
