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

  static String emailValidate(String email) {
    String error = '';
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (email.isEmpty || email == '' || email == null) {
      error = 'Email is required.';
    } else if (!regex.hasMatch(email)) {
      error = 'Your email format is invalid. Please check again';
    }
    return error;
  }
}
