import 'package:flutter/cupertino.dart';

/// Black text style - w900
TextStyle blackTextStyle(double size, Color color, {double height}) =>
    thinTextStyle(size, color, height: height).copyWith(
      fontWeight: FontWeight.w900,
    );

/// Extra-bold text style - w800
TextStyle extraBoldTextStyle(double size, Color color, {double height}) =>
    thinTextStyle(size, color, height: height).copyWith(
      fontWeight: FontWeight.w800,
    );

/// Bold text style - w700
TextStyle boldTextStyle(double size, Color color, {double height}) =>
    thinTextStyle(size, color, height: height).copyWith(
      fontWeight: FontWeight.bold,
    );

/// Semi-bold text style - w600
TextStyle semiBoldTextStyle(double size, Color color, {double height}) =>
    thinTextStyle(size, color, height: height).copyWith(
      fontWeight: FontWeight.w600,
    );

/// Medium text style - w500
TextStyle mediumTextStyle(double size, Color color, {double height}) =>
    thinTextStyle(size, color, height: height).copyWith(
      fontWeight: FontWeight.w500,
    );

/// Normal text style - w400
TextStyle normalTextStyle(double size, Color color, {double height = 1.1}) =>
    thinTextStyle(size, color, height: height).copyWith(
      fontWeight: FontWeight.normal,
    );

/// Light text style - w300
TextStyle lightTextStyle(double size, Color color, {double height}) =>
    thinTextStyle(size, color, height: height).copyWith(
      fontWeight: FontWeight.w300,
    );

/// Extra-light text style - w200
TextStyle extraLightTextStyle(double size, Color color, {double height}) =>
    thinTextStyle(size, color, height: height).copyWith(
      fontWeight: FontWeight.w200,
    );

/// Thin text style - w100
TextStyle thinTextStyle(double size, Color color, {double height}) => TextStyle(
      fontSize: size,
      fontWeight: FontWeight.w100,
      color: color,
      height: height,
    );
