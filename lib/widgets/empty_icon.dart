import 'package:flutter/material.dart';

import '../utils/app_asset.dart';

class EmptyIcon extends StatelessWidget {
  const EmptyIcon({Key key, this.iconPath}) : super(key: key);

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(iconPath ?? AppImages.icEmpty),
      onPressed: null,
    );
  }
}
