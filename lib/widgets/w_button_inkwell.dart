import 'package:flutter/material.dart';

class WButtonInkwell extends StatelessWidget {
  const WButtonInkwell({Key key, this.splashColor, this.onPressed, this.borderRadius, this.child}) : super(key: key);

  final Color splashColor;
  final Widget child;
  final Function() onPressed;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRadius,
        splashColor: splashColor,
        child: child,
        onTap: onPressed,
      ),
    );
  }
}
