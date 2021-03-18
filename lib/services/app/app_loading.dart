import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nft/services/app/app_dialog.dart';
import 'package:provider/provider.dart';

///
/// Install:
/// Declare provider to my_app
/// Provider<AppLoading>(create: (_) => AppLoading()),
///
/// Usage:
/// AppLoading.show(context);
/// AppLoading.hide(context);
///
class AppLoading extends AppDialog {
  /// Show loading dialog shortcut
  /// Change icon at https://pub.dev/packages/flutter_spinkit
  static void show(BuildContext context,
      {String text, Widget textWidget, Widget icon}) {
    context
        .read<AppLoading>()
        .showLoading(context, text: text, textWidget: textWidget, icon: icon);
  }

  /// Hide loading dialog shortcut
  static void hide(BuildContext context) {
    context.read<AppLoading>().hideAppDialog();
  }

  /// Show loading dialog
  /// Change icon at https://pub.dev/packages/flutter_spinkit
  Future<void> showLoading(BuildContext context,
      {String text, Widget textWidget, Widget icon}) async {
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
