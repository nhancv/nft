import 'package:flutter/material.dart';

class WButtonCircle extends StatelessWidget {
  const WButtonCircle(
      {Key key, this.width, this.onPressed, this.child, this.color})
      : super(key: key);

  final double width;
  final Function() onPressed;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 50,
      height: width ?? 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(0),
          primary: color ?? Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}
