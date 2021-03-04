import 'package:flutter/material.dart';

class WButtonRounded extends StatelessWidget {
  const WButtonRounded(
      {Key key,
      this.child,
      this.radius,
      this.onPressed,
      this.background,
      this.splashColor,
      this.borderColor,
      this.borderWidth,
      this.padding})
      : super(key: key);

  final Widget child;
  final double radius;
  final Function() onPressed;
  final Color background;
  final Color splashColor;
  final Color borderColor;
  final double borderWidth;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(background ?? Colors.white),
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
        // elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(padding ?? EdgeInsets.zero),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: borderWidth ?? 1.0),
          borderRadius: BorderRadius.circular(radius ?? 50),
        )),
      ),
    );
  }
}
