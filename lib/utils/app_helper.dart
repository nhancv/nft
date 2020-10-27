import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class AppHelper {
  /// Show popup
  static void showPopup(
      Widget child,
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
