import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nft/utils/app_extension.dart';

/// Show normal bottom sheet
/// final bool res = await appHelperShowBottomSheet(context,
//         (_) {
//       return Container(
//                color: Colors.white,
//                child: Column(
//                  mainAxisSize: MainAxisSize.min,
//                  children: <Widget>[]
//                ),
//              );
//       });

Future<T?> appHelperShowBottomSheet<T>(
    BuildContext context, Widget Function(BuildContext context) child,
    {double? heightFactor, bool interactive = true}) {
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
/// final bool res = await appHelperShowScrollableBottomSheet(context,
//         (_, ScrollController scrollController) {
//       return WSheet(scrollController: scrollController);
//     });
Future<T?> appHelperShowScrollableBottomSheet<T>(
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
Future<T?> appHelperShowPopup<T>(
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

/// Show toast
void appHelperShowToast(
  String msg, {
  Toast? toastLength,
  int? timeInSecForIosWeb,
  Color? backgroundColor,
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
Future<void> appHelperPortraitModeOnly() {
  return SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
}

/// blocks rotation; sets orientation to: landscape
Future<void> appHelperLandscapeModeOnly() {
  return SystemChrome.setPreferredOrientations(
    <DeviceOrientation>[
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ],
  );
}

/// Enable rotation
Future<void> appHelperEnableRotation() {
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
void appHelperNextFocus(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

/// Fullscreen mode
void appHelperEnableFullscreen() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: <SystemUiOverlay>[]);
}

/// Disable fullscreen mode
void appHelperDisableFullscreen() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values);
}
