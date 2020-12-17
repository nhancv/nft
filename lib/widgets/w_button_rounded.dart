import 'package:flutter/material.dart';

class WButtonRounded extends StatelessWidget {
  const WButtonRounded(
      {Key key,
      this.child,
      this.radius,
      this.onPressed,
      this.background,
      this.border})
      : super(key: key);

  final Widget child;
  final double radius;
  final Function() onPressed;
  final Color background;
  final Color border;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: child,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: border ?? Colors.transparent),
        borderRadius: BorderRadius.circular(radius ?? 50),
      ),
      color: background ?? Colors.white,
    );
  }
}
