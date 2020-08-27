import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/services/app_loading.dart';
import 'package:nft/services/local_storage.dart';
import 'package:nft/services/remote/auth_api.dart';
import 'package:nft/utils/app_asset.dart';
import 'package:nft/utils/app_constant.dart';
import 'package:nft/utils/app_route.dart';
import 'package:nft/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<void> myMain() async {
  // Start services later
  WidgetsFlutterBinding.ensureInitialized();

  // Force portrait mode
  await SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp]);

  // Run Application
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        Provider<AuthApi>(create: (_) => AuthApi()),
        Provider<LocalStorage>(create: (_) => LocalStorage()),
        Provider<AppLoadingProvider>(create: (_) => AppLoadingProvider()),
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
        ChangeNotifierProvider<AppThemeProvider>(
            create: (_) => AppThemeProvider()),
        ChangeNotifierProvider<HomeProvider>(
            create: (BuildContext context) =>
                HomeProvider(context.read<AuthApi>())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();
  static final RouteObserver<Route<dynamic>> routeObserver =
      RouteObserver<Route<dynamic>>();

  static NavigatorState get navigator => _navigatorKey.currentState;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final LocaleProvider localeProvider = context.watch<LocaleProvider>();
    return MaterialApp(
      navigatorKey: MyApp._navigatorKey,
      locale: localeProvider.locale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: AppFonts.roboto,
          pageTransitionsTheme: buildPageTransitionsTheme()),
      //https://stackoverflow.com/questions/57245175/flutter-dynamic-initial-route
      //https://github.com/flutter/flutter/issues/12454
      //home: (AppRoute.generateRoute(
      //            const RouteSettings(name: AppConstant.rootPageRoute))
      //        as MaterialPageRoute<dynamic>)
      //    .builder(context),
      initialRoute: AppConstant.rootPageRoute,
      onGenerateRoute: AppRoute.generateRoute,
      navigatorObservers: <NavigatorObserver>[MyApp.routeObserver],
    );
  }

  // Custom page transitions theme
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
