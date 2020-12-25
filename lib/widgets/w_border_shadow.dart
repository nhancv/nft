import 'package:flutter/material.dart';
import 'package:nft/services/safety/base_stateless.dart';

/// Example
/// WBorderShadow(
///       borderColor: const Color(0xFF2CD7FF),
///       shadowColor: const Color(0xFF2CD7FF),
///       backgroundColor: const Color(0xFF00182B),
///       padding: 2.W,
///       child: Container(
///           height: 48.H,
///           child: RaisedButton(
///             padding: EdgeInsets.zero,
///             onPressed: () {},
///             child: WTextShadow(
///               'LOGIN',
///               style: normalTextStyle(
///                 36.SP,
///                 fontFamily: appTheme.assets.fontLibrary3am,
///                 color: const Color(0xFF2CD7FF),
///               ),
///             ),
///           )),
///     ),
// ignore: must_be_immutable
class WBorderShadow extends BaseStateless {
  WBorderShadow(
      {this.child,
      this.shadowColor,
      this.borderRadius,
      this.borderColor,
      this.backgroundColor,
      this.padding,
      this.spreadRadius,
      this.blurRadius,
      Key key})
      : super(key: key);

  final Widget child;
  final Color shadowColor;
  final Color borderColor;
  final Color backgroundColor;
  final double borderRadius;
  final double padding;
  final double spreadRadius;
  final double blurRadius;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.all(borderRadius ?? 5),
      child: _WSingleBorderShadow(
        borderColor: borderColor,
        borderRadius: borderRadius,
        shadowColor: shadowColor,
        spreadRadius: spreadRadius,
        blurRadius: blurRadius,
        child: Container(
          margin: EdgeInsets.all(padding ?? 2),
          child: _WSingleBorderShadow(
            borderColor: Colors.transparent,
            shadowColor: backgroundColor,
            child: Container(
              margin: EdgeInsets.all(padding ?? 2),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _WSingleBorderShadow extends BaseStateless {
  _WSingleBorderShadow(
      {this.child,
      this.shadowColor,
      this.borderRadius,
      this.borderColor,
      this.spreadRadius,
      this.blurRadius,
      Key key})
      : super(key: key);

  final Widget child;
  final Color shadowColor;
  final Color borderColor;
  final double borderRadius;
  final double spreadRadius;
  final double blurRadius;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: child,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: shadowColor ?? Colors.white,
            spreadRadius: spreadRadius ?? 1,
            blurRadius: blurRadius ?? 5,
          ),
        ],
      ),
    );
  }
}
