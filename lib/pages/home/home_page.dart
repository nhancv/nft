import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/services/app/app_dialog.dart';
import 'package:nft/services/app/app_loading.dart';
import 'package:nft/services/app/locale_provider.dart';
import 'package:nft/services/rest_api/api_error.dart';
import 'package:nft/services/rest_api/error_type.dart';
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

class _HomePageState extends State<HomePage>
    with WidgetsBindingObserver, ApiError {
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
    // Get provider to trigger function
    final LocaleProvider localeProvider =
        Provider.of<LocaleProvider>(context, listen: false);
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
                _logout(context);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future<void> onApiError(dynamic error) async {
    final ErrorType errorType = parseErrorType(error);
    await AppDialogProvider.show(context, errorType.message, title: 'Error');
    await Future<void>.delayed(const Duration(seconds: 1));
    if (errorType.code == ErrorCode.unauthorized) {
      _logout(context);
    }
  }

  // Logout function
  Future<void> _logout(BuildContext context) async {
    final HomeProvider provider =
        Provider.of<HomeProvider>(context, listen: false);
    await safeCallApi(
      provider.logout,
      onStart: () async {
        AppLoadingProvider.show(context);
      },
      onFinally: () async {
        AppLoadingProvider.hide(context);
        context.navigator()?.pushReplacementNamed(AppConstant.loginPageRoute);
      },
      apiError: false,
    );
  }
}
