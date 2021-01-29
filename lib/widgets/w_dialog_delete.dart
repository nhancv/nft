import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nft/services/safety/base_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_style.dart';

// AppHelper.showPopup<void>(context,
//     (BuildContext context) {
//   return WDialogDelete(
//     title: '',
//     content: '',
//     onCancelPressed: () {
//       Navigator.of(context).pop();
//     },
//     onDeletePressed: () {
//       Navigator.of(context).pop();
//     },
//   );
// });
class WDialogDelete extends StatefulWidget {
  const WDialogDelete(
      {Key key,
      this.title,
      this.content,
      this.onCancelPressed,
      this.onDeletePressed})
      : super(key: key);
  final String title;
  final String content;
  final Function() onCancelPressed;
  final Function() onDeletePressed;

  @override
  _WDialogDeleteState createState() => _WDialogDeleteState();
}

class _WDialogDeleteState extends BaseStateful<WDialogDelete> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Material(
      color: Colors.transparent,
      child: CupertinoAlertDialog(
        content: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Text(
                  widget.title ?? '',
                  style:
                      semiBoldTextStyle(17.SP, color: const Color(0xFF1C202E)),
                ),
                SizedBox(height: 5.H),
                Text(
                  widget.content ?? '',
                  style: normalTextStyle(13.SP, color: const Color(0xFF1C202E)),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {},
            child: Container(
              color: Colors.transparent,
              height: 44.H,
              alignment: Alignment.center,
              child: Text(
                'Cancel',
                style: normalTextStyle(
                  17.SP,
                  color: const Color(0xFF777982),
                  fontFamily: appTheme.assets.fontIOSDefault,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              color: Colors.transparent,
              height: 44.H,
              alignment: Alignment.center,
              child: Text(
                'Delete',
                style: boldTextStyle(
                  17.SP,
                  color: const Color(0xFFFF453A),
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
