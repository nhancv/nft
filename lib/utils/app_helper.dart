import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nft/utils/app_extension.dart';

class AppHelper {
  /// Show normal bottom sheet
  /// final bool res = await AppHelper.showBottomSheet(context,
  //         (_) {
  //       return Container(
  //                color: Colors.white,
  //                child: Column(
  //                  mainAxisSize: MainAxisSize.min,
  //                  children: <Widget>[]
  //                ),
  //              );
  //       });
  static Future<T> showBottomSheet<T>(
      BuildContext context, Widget Function(BuildContext context) child,
      {double heightFactor, bool interactive = true}) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: interactive,
      enableDrag: interactive,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: heightFactor,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.W),
              topRight: Radius.circular(30.W),
            ),
            child: child(context),
          ),
        );
      },
    );
  }

  /// Show bottom sheet scrollable
  /// final bool res = await AppHelper.showScrollableBottomSheet(context,
  //         (_, ScrollController scrollController) {
  //       return WSheet(scrollController: scrollController);
  //     });
  static Future<T> showScrollableBottomSheet<T>(
    BuildContext context,
    Widget Function(BuildContext context, ScrollController scrollController)
        child,
  ) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        final Size size = MediaQuery.of(context).size;
        final double initHeight = 1 - 100.H / size.height;
        return DraggableScrollableSheet(
            // padding from top of screen on load
            initialChildSize: initHeight,
            // full screen on scroll
            maxChildSize: 1,
            minChildSize: initHeight,
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.W),
                    topRight: Radius.circular(30.W),
                  ),
                  child: child(context, scrollController));
            });
      },
    );
  }

  /// Show popup
  static Future<T> showPopup<T>(
    BuildContext context,
    Widget Function(BuildContext context) builder, {
    bool barrierDismissible = false,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: builder,
    );
  }

  /// Show snack bar
  static void showFlushBar(BuildContext context, String message) {
    Flushbar<void>(
            message: message,
            duration: const Duration(milliseconds: 2000),
            flushbarStyle: FlushbarStyle.GROUNDED)
        .show(context);
  }

  /// Show toast
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

  /// Change next focus
  static void nextFocus(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  /// Fullscreen mode
  static void enableFullscreen() {
    SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[]);
  }

  /// Disable fullscreen mode
  static void disableFullscreen() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }
}
