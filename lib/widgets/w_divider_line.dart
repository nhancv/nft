import 'package:flutter/material.dart';

class WDividerLine extends StatelessWidget {
  const WDividerLine({Key key, this.width, this.height, this.color})
      : super(key: key);

  final double width;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 0.5,
      color: color ?? const Color(0xFF979797),
    );
  }
}
