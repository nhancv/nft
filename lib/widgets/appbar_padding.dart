
import 'package:flutter/material.dart';

class AppBarPadding extends StatelessWidget {
  final Widget background;
  final Widget child;
  final Color backgroundColor;

  const AppBarPadding({Key key, this.child, this.background, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        background ?? Container(color: backgroundColor ?? Colors.white, height: statusBarHeight),
        Container(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: child ?? Container(),
        )
      ],
    );
  }
}
