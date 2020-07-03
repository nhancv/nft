import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nft/widgets/screen_widget.dart';

class NormalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      body: Column(children: <Widget>[
        ScreenHeader(),
        Expanded(
          child: ScreenBody(),
        ),
        ScreenFooter()
      ]),
    );
  }
}

class ScreenHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ScreenFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
