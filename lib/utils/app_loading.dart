import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nft/services/providers/providers.dart';
import 'package:nft/utils/app_dialog.dart';

///
/// Install:
/// Declare provider to services/providers/providers.dart
/// final gAppLoadingProvider = Provider((_) => AppLoading());
///
/// Usage:
/// AppLoading.show(context);
/// AppLoading.hide(context);
///
class AppLoading extends AppDialog {
  /// Show loading dialog shortcut
  /// Change icon at https://pub.dev/packages/flutter_spinkit
  static void show(WidgetRef ref, {String? text, Widget? textWidget, Widget? icon}) {
    ref.read(pAppLoadingProvider).showLoading(ref.context, text: text, textWidget: textWidget, icon: icon);
  }

  /// Hide loading dialog shortcut
  static void hide(WidgetRef ref) {
    ref.read(pAppLoadingProvider).hideAppDialog();
  }

  /// Show loading dialog
  /// Change icon at https://pub.dev/packages/flutter_spinkit
  Future<void> showLoading(BuildContext context, {String? text, Widget? textWidget, Widget? icon}) async {
    return showAppDialog(
      context,
      Material(
        type: MaterialType.transparency,
        child: Center(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                icon ?? const SpinKitDoubleBounce(color: Colors.white),
                if (textWidget != null)
                  textWidget
                else if (text != null)
                  Text(
                    text,
                    style: const TextStyle(color: Colors.white),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Hide loading dialog
  void hideLoading({bool isClean = false}) {
    hideAppDialog(isClean: isClean);
  }
}
