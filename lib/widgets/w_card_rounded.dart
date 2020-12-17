import 'package:flutter/material.dart';
import 'package:nft/utils/app_extension.dart';

class WCardRounded extends StatelessWidget {
  const WCardRounded({Key key, this.child, this.radius}) : super(key: key);

  final Widget child;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 5.W)),
      child: child,
    );
  }
}
