import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/my_app.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/services/app_loading.dart';
import 'package:nft/utils/app_constant.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/widgets/screen_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// Log app life cycle state
    logger.d(state);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      body: Column(children: const <Widget>[
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
  const HomeScreenHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(S.of(context).hello),
        FlatButton(
          onPressed: () {
            // Get current locale
            final String currentLocale = Intl.getCurrentLocale();
            // Change to new locale
            if (currentLocale == 'en') {
              context.read<LocaleProvider>().updateLocale(const Locale('vi'));
            } else {
              context.read<LocaleProvider>().updateLocale(const Locale('en'));
            }
          },
          child: const Text('press me'),
        ),
        FlatButton(
          key: const Key('callApiBtnKey'),
          onPressed: () async {
            AppLoadingProvider.show(context);
            await context.read<HomeProvider>().login();
            AppLoadingProvider.hide(context);
          },
          child: const Text('call api'),
        ),
        Consumer<HomeProvider>(
          builder: (_, HomeProvider value, Widget child) {
            return Text(
              value.response,
              textAlign: TextAlign.center,
            );
          },
        ),
        RaisedButton(
          key: const Key(AppConstant.counterPageRoute),
          onPressed: () {
            Navigator.pushNamed(context, AppConstant.counterPageRoute,
                arguments: 'From Home ${DateTime.now()}');
          },
          child: const Text('Counter Page'),
        ),
        RaisedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppConstant.tutorialPageRoute);
          },
          child: const Text('Open tutorial overlay page'),
        )
      ],
    );
  }
}

class HomeScreenFooter extends StatelessWidget {
  const HomeScreenFooter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
