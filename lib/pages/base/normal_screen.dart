
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nft/widgets/screen_widget.dart';

class NormalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      body: Column(children: <Widget>[
        Expanded(
          child: _body(),
        ),
      ]),
    );
  }

  Widget _body() {
    return Container();
  }
}
