import 'package:flutter/material.dart';

class WTextShadow extends StatelessWidget {
  const WTextShadow(this.text, {this.style, this.textAlign, Key? key}) : super(key: key);

  final String? text;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      style: style?.copyWith(
        shadows: <Shadow>[
          const Shadow(
            blurRadius: 0.0,
            color: Colors.white,
          ),
          const Shadow(
            blurRadius: 10.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
