import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nft/widgets/screen_widget.dart';

class NormalPage extends StatelessWidget {
  const NormalPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      body: Column(
        children: const <Widget>[
          ScreenHeader(),
          Expanded(
            child: ScreenBody(),
          ),
          ScreenFooter()
        ],
      ),
    );
  }
}

/// Header widget
class ScreenHeader extends StatelessWidget {
  const ScreenHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/// Body widget
class ScreenBody extends StatelessWidget {
  const ScreenBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/// Footer widget
class ScreenFooter extends StatelessWidget {
  const ScreenFooter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
