import 'package:flutter/material.dart';

// View auto resized when keyboard open
class WSysPadding extends StatelessWidget {
  const WSysPadding({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    return AnimatedContainer(
      padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
      duration: const Duration(milliseconds: 300),
      child: child,
    );
  }
}
