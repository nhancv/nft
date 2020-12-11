import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/services/app/app_dialog.dart';
import 'package:nft/services/app/app_loading.dart';
import 'package:nft/services/app/locale_provider.dart';
import 'package:nft/services/rest_api/api_error.dart';
import 'package:nft/services/rest_api/api_error_type.dart';
import 'package:nft/services/safety/base_stateful.dart';
import 'package:nft/services/safety/page_stateful.dart';
import 'package:nft/utils/app_constant.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/utils/app_route.dart';
import 'package:nft/widgets/p_appbar_empty.dart';
import 'package:nft/widgets/w_dismiss_keyboard.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends PageStateful<HomePage>
    with WidgetsBindingObserver {
  HomeProvider homeProvider;

  @override
  void initDependencies(BuildContext context) {
    super.initDependencies(context);
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
  }

  @override
  void afterFirstBuild(BuildContext context) {}

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
    super.build(context);
    return PAppBarEmpty(
      child: WDismissKeyboard(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(S.of(context).hello),
            ),

            // As default, when user change language in device setting
            // -> the locale will change appropriately
            // This button provides user can change the locale manually
            FlatButton(
              onPressed: () {
                // Get current locale
                final String currentLocale = Intl.getCurrentLocale();
                // Change to new locale
                if (currentLocale == 'en') {
                  localeProvider.locale = const Locale('vi');
                } else {
                  localeProvider.locale = const Locale('en');
                }
              },
              child: const Text('Translate'),
            ),

            const SizedBox(height: 10),
            // Example to use selector instead consumer to optimize render performance
            Selector<HomeProvider, String>(
              selector: (_, HomeProvider provider) =>
                  provider.token?.toJson()?.toString() ?? '',
              builder: (_, String tokenInfo, __) {
                return Text(
                  tokenInfo,
                  textAlign: TextAlign.center,
                );
              },
            ),

            const SizedBox(height: 10),
            // Navigate to counter page with current timestamp as argument
            RaisedButton(
              key: const Key(AppConstant.counterPageRoute),
              onPressed: () {
                Navigator.pushNamed(context, AppConstant.counterPageRoute,
                    arguments: 'From Home ${DateTime.now()}');
              },
              child: const Text('Counter Page'),
            ),

            const SizedBox(height: 10),
            // Logout
            // Navigate to login
            RaisedButton(
              key: const Key(AppConstant.loginPageRoute),
              onPressed: () async {
                logout(context);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

}
