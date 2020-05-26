
import 'package:flutter/material.dart';

class DividerLine extends StatelessWidget {
  final double width;
  final double height;

  const DividerLine({Key key, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 0.5,
      color: Color.fromRGBO(226, 226, 226, 1),
    );
  }
}
