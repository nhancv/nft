import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/models/remote/log_in_response.dart';
import 'package:nft/my_app.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/services/app_dialog.dart';
import 'package:nft/services/app_loading.dart';
import 'package:nft/services/remote/api_error.dart';
import 'package:nft/utils/app_constant.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/widgets/screen_widget.dart';
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
    final HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    return ScreenWidget(
      body: Column(
        children: <Widget>[
          Text(S.of(context).hello),

          // As default, when user change language in device setting
          // -> the locale will change appropriately
          // This button provides user can change the locale manually
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

          // Example call api with success response
          RaisedButton(
            key: const Key('callApiBtnKey'),
            onPressed: () async {
              AppLoadingProvider.show(context);
              await homeProvider.login();
              AppLoadingProvider.hide(context);
              // todo after hide loading
            },
            child: const Text('call api'),
          ),

          // Example call api with success http code but with error response,
          // and how to use function response data instead property approach.
          RaisedButton(
            key: const Key('callApiErrorBtnKey'),
            onPressed: () async {
              AppLoadingProvider.show(context);
              final LoginResponse loginResponse =
                  await homeProvider.logInWithError();
              AppLoadingProvider.hide(context);
              // todo with response after hide loading
              logger.d(loginResponse);
            },
            child: const Text('call api with error'),
          ),

          // Example call api with exception return to ui
          // Note: Exception make app can not hide the app loading with previous ways
          RaisedButton(
            key: const Key('callApiExceptionBtnKey'),
            onPressed: () async {
              safeCallApi(() => homeProvider.logInWithException(),
                  onStart: () async {
                AppLoadingProvider.show(context);
              }, onCompleted: () async {
                AppLoadingProvider.hide(context);
              });
            },
            child: const Text('call api with exception'),
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

          // Navigate to counter page with current timestamp as argument
          RaisedButton(
            key: const Key(AppConstant.counterPageRoute),
            onPressed: () {
              Navigator.pushNamed(context, AppConstant.counterPageRoute,
                  arguments: 'From Home ${DateTime.now()}');
            },
            child: const Text('Counter Page'),
          ),

          // Example about custom overlay page
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppConstant.tutorialPageRoute);
            },
            child: const Text('Open tutorial overlay page'),
          )
        ],
      ),
    );
  }

  @override
  Future<void> onApiError(dynamic error) async {
    logger.e(error);
    AppDialogProvider.show(context, error.toString());
  }
}
