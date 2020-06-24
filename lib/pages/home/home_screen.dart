import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/my_app.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/widgets/screen_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      body: Column(children: <Widget>[
        HomeScreenHeader(),
        Expanded(
          child: HomeScreenBody(),
        ),
        HomeScreenFooter()
      ]),
    );
  }
}

class HomeScreenHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(S.of(context).hello),
          FlatButton(
            child: Text('press me'),
            onPressed: () {
              final currentLocale = Intl.getCurrentLocale();
              if (currentLocale == 'en') {
                context.read<LocaleProvider>().updateLocale(Locale('vi'));
              } else {
                context.read<LocaleProvider>().updateLocale(Locale('en'));
              }
            },
          ),
          FlatButton(
            child: Text('call api'),
            onPressed: () {
              context.read<HomeProvider>().login();
            },
          ),
          Text(
            '${context.watch<HomeProvider>().response}',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class HomeScreenFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
