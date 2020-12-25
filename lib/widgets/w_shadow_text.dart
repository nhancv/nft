import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nft/services/safety/base_stateless.dart';

// ignore: must_be_immutable
class WShadowText extends BaseStateless {
  WShadowText(this.text, {this.style, Key key}) : super(key: key);

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Text(
      text ?? '',
      style: style.copyWith(
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
