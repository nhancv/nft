
import 'package:flutter/material.dart';

class AppBarPadding extends StatelessWidget {
  final Widget background;
  final Widget child;

  const AppBarPadding({Key key, this.child, this.background}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        background ?? Container(color: Colors.white),
        Container(
          padding: EdgeInsets.only(top: statusBarHeight),
          child: child ?? Container(),
        )
      ],
    );
  }
}
