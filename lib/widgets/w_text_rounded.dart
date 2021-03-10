import 'package:flutter/material.dart';
import 'package:nft/services/safety/base_stateless.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_style.dart';

// ignore: must_be_immutable
class WTextRounded extends BaseStateless {
  WTextRounded({Key key, this.text, this.color}) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.all(2.W),
      margin: EdgeInsets.symmetric(horizontal: 5.W),
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(10.W),
      ),
      child: Text(
        text ?? '',
        textAlign: TextAlign.center,
        style: boldTextStyle(15.SP, color: color),
      ),
    );
  }
}
