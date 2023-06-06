import 'package:flutter/material.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_style.dart';

class WTextRounded extends StatelessWidget {
  const WTextRounded({
    Key? key,
    this.text,
    this.color,
    this.background,
    this.textStyle,
  }) : super(key: key);

  final String? text;
  final Color? color;
  final Color? background;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.W),
      margin: EdgeInsets.symmetric(horizontal: 5.W, vertical: 5.W),
      decoration: BoxDecoration(
        color: background,
        border: Border.all(
          color: color ?? textStyle?.color ?? Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(10.W),
      ),
      child: Text(
        text ?? '',
        textAlign: TextAlign.center,
        style: textStyle ?? boldTextStyle(15.SP, color: color),
      ),
    );
  }
}
