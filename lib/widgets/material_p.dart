import 'package:flutter/material.dart';

class MaterialP extends StatelessWidget {
  const MaterialP({@required this.child, Key key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: child,
    );
  }
}
