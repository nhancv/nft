import 'package:flutter/material.dart';

class ScreenWidget extends StatelessWidget {
  const ScreenWidget(
      {Key key,
      this.body,
      this.backgroundColor,
      this.bottomNavigationBar,
      this.unFocus})
      : super(key: key);

  final Widget body;
  final Color backgroundColor;
  final Widget bottomNavigationBar;
  final Function() unFocus;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        if (unFocus != null) {
          unFocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: backgroundColor ?? Colors.transparent,
        bottomNavigationBar: bottomNavigationBar,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            child: body),
      ),
    );
  }
}
