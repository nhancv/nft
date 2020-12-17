import 'package:flutter/material.dart';

class WButtonRaisedFlat extends StatelessWidget {
  const WButtonRaisedFlat({
    Key key,
    this.onPressed,
    this.child,
    this.color,
    this.splashColor,
  }) : super(key: key);
  final Function() onPressed;
  final Widget child;
  final Color color;
  final Color splashColor;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      child: child,
      splashColor: splashColor ?? const Color(0xFFFFCE9A),
      color: color ?? Colors.transparent,
      elevation: 0,
      padding: EdgeInsets.zero,
      highlightElevation: 0,
    );
  }
}
