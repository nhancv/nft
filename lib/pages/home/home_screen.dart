import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nft/my_app.dart';
import 'package:nft/provider/i18n/app_localizations.dart';
import 'package:nft/widgets/screen_widget.dart';

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
          Text(AppLocalizations.of(context).translate('title')),
          FlatButton(
            child: Text('press me'),
            onPressed: () {
              final currentLocale = AppLocalizations.of(context).locale;
              if (currentLocale == Locale('en')) {
                BlocProvider.of<LocaleBloc>(context).add(Locale('vi'));
              } else {
                BlocProvider.of<LocaleBloc>(context).add(Locale('en'));
              }
            },
          )
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
