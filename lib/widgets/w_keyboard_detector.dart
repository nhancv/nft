import 'package:flutter/material.dart';
import 'package:nft/utils/app_route.dart';

// // AppRoute from nft template
// WKeyboardDetector(
//     onState: (bool isOpen, double keyboardHeight) {
//       print('isOpen: $isOpen');
//     },
//   ),
class WKeyboardDetector extends StatefulWidget {
  const WKeyboardDetector({
    this.onState,
    Key key,
  }) : super(key: key);

  final Function(bool isOpen, double keyboardHeight) onState;

  @override
  _WKeyboardDetectorState createState() => _WKeyboardDetectorState();
}

class _WKeyboardDetectorState extends State<WKeyboardDetector> {
  bool _keyboardVisible = false;
  double _keyboardHeight = 0;

  set keyboardVisible(bool value) {
    if (_keyboardVisible != value) {
      _keyboardVisible = value;
      if (widget.onState != null) {
        widget.onState(_keyboardVisible, _keyboardHeight);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _keyboardHeight = MediaQuery.of(AppRoute.I.appContext).viewInsets.bottom;
    keyboardVisible = _keyboardHeight > 0;
    return Container();
  }
}
