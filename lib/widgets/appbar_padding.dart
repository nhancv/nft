import 'package:flutter/material.dart';
import 'package:nft/widgets/screen_widget.dart';

class AppBarPadding extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const AppBarPadding({Key key, this.child, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      backgroundColor: backgroundColor ?? Colors.white,
      body: child ?? Container(),
    );
  }
}
