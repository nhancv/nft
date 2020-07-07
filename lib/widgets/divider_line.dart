import 'package:flutter/material.dart';

class DividerLine extends StatelessWidget {
  const DividerLine({Key key, this.width, this.height}) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 0.5,
      color: const Color(0xFF979797),
    );
  }
}
