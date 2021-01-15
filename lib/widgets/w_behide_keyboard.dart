import 'package:flutter/material.dart';
import 'package:nft/utils/app_route.dart';

class WBehindKeyboard extends StatefulWidget {
  const WBehindKeyboard({Key key, @required this.child, this.reversed = false})
      : super(key: key);

  final Widget child;
  final bool reversed;

  @override
  _WBehindKeyboardState createState() => _WBehindKeyboardState();
}

class _WBehindKeyboardState extends State<WBehindKeyboard> {
  bool _keyboardVisible = false;

  @override
  Widget build(BuildContext context) {
    _keyboardVisible =
        MediaQuery.of(AppRoute.I.appContext).viewInsets.bottom != 0;
    return Opacity(
      opacity: (widget.reversed ? !_keyboardVisible : _keyboardVisible) ? 0 : 1,
      child: widget.child,
    );
  }
}
