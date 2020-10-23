import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/pages/login/login_provider.dart';
import 'package:nft/services/app_dialog.dart';
import 'package:nft/services/app_loading.dart';
import 'package:nft/services/local/credential.dart';
import 'package:nft/services/local/storage.dart';
import 'package:nft/services/local/storage_preferences.dart';
import 'package:nft/services/remote/user_api.dart';
import 'package:nft/utils/app_asset.dart';
import 'package:nft/utils/app_constant.dart';
import 'package:nft/utils/app_route.dart';
import 'package:nft/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<void> myMain() async {
  /// Start services later
  WidgetsFlutterBinding.ensureInitialized();

  /// Force portrait mode
  await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]);

  /// Run Application
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        Provider<AppRoute>(create: (_) => AppRoute()),
        Provider<Storage>(create: (_) => StoragePreferences()),
        ChangeNotifierProvider<Credential>(
            create: (BuildContext context) =>
                Credential(context.read<Storage>())),
        ProxyProvider<Credential, UserApi>(
            create: (_) => UserApi(),
            update: (_, Credential credential, UserApi userApi) {
              return userApi..token = credential.token;
            }),
        Provider<AppLoadingProvider>(create: (_) => AppLoadingProvider()),
        Provider<AppDialogProvider>(create: (_) => AppDialogProvider()),
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
        ChangeNotifierProvider<AppThemeProvider>(
            create: (_) => AppThemeProvider()),
        ChangeNotifierProvider<HomeProvider>(
            create: (BuildContext context) => HomeProvider(
                  context.read<UserApi>(),
                  context.read<Credential>(),
                )),
        ChangeNotifierProvider<LoginProvider>(
            create: (BuildContext context) => LoginProvider(
                  context.read<UserApi>(),
                  context.read<Credential>(),
                )),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // Example about load credential to init page
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final bool hasCredential =
          await context.read<Credential>().loadCredential();
      if (hasCredential) {
        context.navigator()?.pushReplacementNamed(AppConstant.homePageRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get providers
    final AppRoute appRoute = context.watch<AppRoute>();
    final LocaleProvider localeProvider = context.watch<LocaleProvider>();
    final AppTheme appTheme = context.theme();
    // Build Material app
    return MaterialApp(
      navigatorKey: appRoute.navigatorKey,
      locale: localeProvider.locale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: appTheme.buildThemeData(),
      //https://stackoverflow.com/questions/57245175/flutter-dynamic-initial-route
      //https://github.com/flutter/flutter/issues/12454
      //home: (appRoute.generateRoute(
      ///            const RouteSettings(name: AppConstant.rootPageRoute))
      ///        as MaterialPageRoute<dynamic>)
      ///    .builder(context),
      initialRoute: AppConstant.rootPageRoute,
      onGenerateRoute: appRoute.generateRoute,
      navigatorObservers: <NavigatorObserver>[appRoute.routeObserver],
    );
  }

  /// Custom page transitions theme
  PageTransitionsTheme buildPageTransitionsTheme() {
    return const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder(),
      },
    );
  }
}

class LocaleProvider with ChangeNotifier {
  Locale locale = Locale(ui.window.locale?.languageCode ?? ' en');

  Future<void> updateLocale(Locale locale) async {
    this.locale = locale;
    notifyListeners();
  }
}
