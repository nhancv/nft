import 'package:flutter/cupertino.dart';

TextStyle boldTextStyle(double size, Color color, {double height}) => TextStyle(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: color,
      height: height,
    );

TextStyle mediumTextStyle(double size, Color color, {double height}) =>
    TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w500,
      color: color,
      height: height,
    );

TextStyle normalTextStyle(double size, Color color, {double height = 1.1}) =>
    TextStyle(
      fontSize: size,
      fontWeight: FontWeight.normal,
      color: color,
      height: height,
    );

TextStyle lightTextStyle(double size, Color color, {double height}) =>
    TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w300,
      color: color,
      height: height,
    );
