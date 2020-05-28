import 'package:flutter/material.dart';

class RippleEffect extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final ShapeBorder customBorder;
  final Function() onTap;

  const RippleEffect(
      {Key key,
      this.width,
      this.height,
      this.customBorder,
      this.child,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Colors.transparent,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: customBorder ?? CircleBorder(),
          child: child,
          onTap: onTap,
        ),
      ),
    );
  }
}

class CircleRippleEffect extends RippleEffect {
  final double size;

  CircleRippleEffect({child, this.size, customBorder, onTap})
      : super(
            child: child,
            width: size,
            height: size,
            customBorder: customBorder,
            onTap: onTap);
}
