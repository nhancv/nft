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
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(color ?? Colors.transparent),
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          final Color sColor = splashColor ?? Colors.grey.withAlpha(150);
          if (states.contains(MaterialState.hovered)) {
            return sColor;
          }
          if (states.contains(MaterialState.pressed)) {
            return sColor;
          }
          return null; // Defer to the widget's default.
        }),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
    );
  }
}
