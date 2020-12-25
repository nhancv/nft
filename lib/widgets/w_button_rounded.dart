import 'package:flutter/material.dart';

class WButtonRounded extends StatelessWidget {
  const WButtonRounded(
      {Key key,
      this.child,
      this.radius,
      this.onPressed,
      this.background,
      this.borderColor,
      this.borderWidth})
      : super(key: key);

  final Widget child;
  final double radius;
  final Function() onPressed;
  final Color background;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: child,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 1.0),
        borderRadius: BorderRadius.circular(radius ?? 50),
      ),
      color: background ?? Colors.white,
    );
  }
}
