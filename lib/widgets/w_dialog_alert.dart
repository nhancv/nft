import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nft/services/safety/base_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_style.dart';

// AppHelper.showPopup<void>(context,
//     (BuildContext context) {
//   return WDialogAlert(
//     title: '',
//     content: '',
//     onCancelPressed: () {
//       Navigator.of(context).pop();
//     },
//     onConfirmPressed: () {
//       Navigator.of(context).pop();
//     },
//   );
// });
class WDialogAlert extends StatefulWidget {
  const WDialogAlert({
    Key key,
    this.title,
    this.titleStyle,
    this.content,
    this.contentStyle,
    this.cancelTitle,
    this.cancelTitleStyle,
    this.onCancelPressed,
    this.confirmTitle,
    this.confirmTitleStyle,
    this.onConfirmPressed,
  }) : super(key: key);
  final String title;
  final TextStyle titleStyle;
  final String content;
  final TextStyle contentStyle;
  final String cancelTitle;
  final TextStyle cancelTitleStyle;
  final Function() onCancelPressed;
  final String confirmTitle;
  final TextStyle confirmTitleStyle;
  final Function() onConfirmPressed;

  @override
  _WDialogAlertState createState() => _WDialogAlertState();
}

class _WDialogAlertState extends BaseStateful<WDialogAlert> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      color: Colors.transparent,
      child: CupertinoAlertDialog(
        title: Text(
          widget.title ?? '',
          style: widget.titleStyle ??
              semiBoldTextStyle(17.SP, color: const Color(0xFF1C202E)),
        ),
        content: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(height: 5.H),
                Text(
                  widget.content ?? '',
                  style: widget.contentStyle ??
                      normalTextStyle(13.SP, color: const Color(0xFF1C202E)),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: widget.onCancelPressed,
            child: Container(
              color: Colors.transparent,
              height: 44.H,
              alignment: Alignment.center,
              child: Text(
                widget.cancelTitle ?? 'Cancel',
                style: widget.cancelTitleStyle ??
                    normalTextStyle(
                      17.SP,
                      color: const Color(0xFF777982),
                      fontFamily: appTheme.assets.fontIOSDefault,
                    ),
              ),
            ),
          ),
          GestureDetector(
            onTap: widget.onConfirmPressed,
            child: Container(
              color: Colors.transparent,
              height: 44.H,
              alignment: Alignment.center,
              child: Text(
                widget.confirmTitle ?? 'Confirm',
                style: widget.confirmTitleStyle ??
                    boldTextStyle(
                      17.SP,
                      color: Colors.blue,
                      fontFamily: appTheme.assets.fontIOSDefault,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
