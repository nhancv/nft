import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppHelper {
  static void showPopup(Widget child, BuildContext context,
      {Function onAction}) {
    showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: child,
          );
        });
  }

}
