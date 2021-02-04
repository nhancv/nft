import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nft/services/safety/base_stateful.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_style.dart';
import 'package:nft/widgets/w_dialog_alert.dart';

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
  const WDialogDelete({
    Key key,
    this.title,
    this.content,
    this.onCancelPressed,
    this.onDeletePressed,
  }) : super(key: key);
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
    return WDialogAlert(
      title: widget.title,
      content: widget.content,
      onCancelPressed: widget.onCancelPressed,
      confirmTitle: 'Delete',
      confirmTitleStyle: boldTextStyle(
        17.SP,
        color: const Color(0xFFFF453A),
        fontFamily: appTheme.assets.fontIOSDefault,
      ),
      onConfirmPressed: widget.onDeletePressed,
    );
  }
}
