import 'package:flutter/material.dart';
import 'package:nft/services/safety/base_stateless.dart';

// ignore: must_be_immutable
class WCardShadow extends BaseStateless {
  WCardShadow(
      {this.child,
      this.shadowColor,
      this.borderRadius,
      this.borderColor,
      this.cardColor,
      this.spreadRadius,
      this.blurRadius,
      this.extraShadows,
      Key key})
      : super(key: key);

  final Widget child;
  final Color shadowColor;
  final Color borderColor;
  final Color cardColor;
  final double borderRadius;
  final double spreadRadius;
  final double blurRadius;
  final List<BoxShadow> extraShadows;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: child,
      decoration: BoxDecoration(
        color: cardColor,
        border: Border.all(color: borderColor ?? Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: shadowColor ?? Colors.white,
            spreadRadius: spreadRadius ?? 1,
            blurRadius: blurRadius ?? 5,
          ),
          ...extraShadows ?? <BoxShadow>[],
        ],
      ),
    );
  }
}
