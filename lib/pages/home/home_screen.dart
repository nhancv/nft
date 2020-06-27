import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/my_app.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/pages/home/slideup_widget.dart';
import 'package:nft/services/app_loading.dart';
import 'package:nft/utils/app_constant.dart';
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
  SlideUpController slideUpController = SlideUpController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
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
                onPressed: () async {
                  AppLoadingProvider.show(context);
                  await context.read<HomeProvider>().login();
                  AppLoadingProvider.hide(context);
                },
              ),
              Consumer<HomeProvider>(
                builder: (_, value, child) {
                  return Text(
                    '${value.response}',
                    textAlign: TextAlign.center,
                  );
                },
              ),
              RaisedButton(
                key: Key(AppConstant.counterScreenRoute),
                child: Text('Counter Screen'),
                onPressed: () {
                  Navigator.pushNamed(context, AppConstant.counterScreenRoute,
                      arguments: 'Argument from Home');
                },
              ),
              RaisedButton(
                child: Text('Slide up widget'),
                onPressed: () {
                  slideUpController.toggle();
                },
              )
            ],
          ),
        ),
        SlideUpWidget(
          controller: slideUpController,
        )
      ],
    );
  }
}

class HomeScreenFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
