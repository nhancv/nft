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
    return const ScreenWidget(
      body: HomeScreenBody(),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get provider to trigger function
    final LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
    final HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    return Column(
      children: <Widget>[
        Text(S.of(context).hello),
        FlatButton(
          onPressed: () {
            // Get current locale
            final String currentLocale = Intl.getCurrentLocale();
            // Change to new locale
            if (currentLocale == 'en') {
              localeProvider.updateLocale(const Locale('vi'));
            } else {
              localeProvider.updateLocale(const Locale('en'));
            }
          },
          child: const Text('press me'),
        ),
        FlatButton(
          key: const Key('callApiBtnKey'),
          onPressed: () async {
            AppLoadingProvider.show(context);
            await homeProvider.login();
            AppLoadingProvider.hide(context);
          },
          child: const Text('call api'),
        ),

        // Example to use selector instead consumer to optimize render performance
        Selector<HomeProvider, String>(
          selector: (_, HomeProvider provider) => provider.response,
          builder: (_, String response, __) {
            return Text(
              response,
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
