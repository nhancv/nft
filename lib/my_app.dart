import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/pages/base/content_page.dart';
import 'package:nft/pages/counter/counter_page.dart';
import 'package:nft/pages/home/home_page.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/pages/tutorial/tutorial_page.dart';
import 'package:nft/services/app_loading.dart';
import 'package:nft/services/local_storage.dart';
import 'package:nft/services/remote/auth_api.dart';
import 'package:nft/utils/app_asset.dart';
import 'package:nft/utils/app_constant.dart';
import 'package:nft/utils/app_theme.dart';
import 'package:nft/widgets/appbar_padding.dart';
import 'package:provider/provider.dart';

Future<void> myMain() async {
  // Start services later
  WidgetsFlutterBinding.ensureInitialized();

  // Force portrait mode
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Run Application
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AuthApi()),
        Provider(create: (_) => LocalStorage()),
        Provider(create: (_) => AppLoadingProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(
            create: (context) => HomeProvider(context.read<AuthApi>())),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp(
            locale: localeProvider.locale,
            supportedLocales: S.delegate.supportedLocales,
            localizationsDelegates: [
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
            initialRoute: AppConstant.rootPageRoute,
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
                case AppConstant.rootPageRoute:
                  return MaterialPageRoute(
                      builder: (_) => ContentPage(body: HomePage()));
                case AppConstant.tutorialPageRoute:
                  return TutorialPage();
                case AppConstant.counterPageRoute:
                  return MaterialPageRoute(
                      builder: (_) => ContentPage(
                          body: CounterPage(argument: settings.arguments)));
                default:
                  return MaterialPageRoute(
                      builder: (_) => ContentPage(body: HomePage()));
              }
            },
          );
        },
      ),
    );
  }

  // Custom page transitions theme
  PageTransitionsTheme buildPageTransitionsTheme() {
    return PageTransitionsTheme(
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
