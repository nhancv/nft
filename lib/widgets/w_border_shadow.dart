import 'package:flutter/material.dart';
import 'package:nft/services/safety/base_stateless.dart';

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
    return _buildBorder();
  }

  /// Build single border shadow
  Widget _buildBorder() {
    return _WSingleBorderShadow(
      borderColor: borderColor,
      borderRadius: borderRadius,
      shadowColor: shadowColor,
      spreadRadius: spreadRadius,
      blurRadius: blurRadius,
      child: Container(
        margin: EdgeInsets.all(padding ?? 5),
        child: _WSingleBorderShadow(
          borderColor: Colors.transparent,
          shadowColor: backgroundColor,
          child: Container(
            margin: EdgeInsets.all(padding ?? 5),
            child: child,
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
            spreadRadius: spreadRadius ?? 2,
            blurRadius: blurRadius ?? 10,
          ),
        ],
      ),
    );
  }
}
