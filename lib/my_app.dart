import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/pages/counter/counter_screen.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/pages/home/home_screen.dart';
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
      child: Consumer2<LocaleProvider, AppThemeProvider>(
        builder: (context, localeProvider, appThemeProvider, child) {
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
            initialRoute: AppConstant.rootRoute,
            routes: <String, WidgetBuilder>{
              AppConstant.rootRoute: (context) => AppContent(
                  theme: appThemeProvider.theme, screen: HomeScreen()),
              AppConstant.counterScreenRoute: (context) => AppContent(
                  theme: appThemeProvider.theme,
                  screen: CounterScreen(
                      argument: ModalRoute.of(context)?.settings?.arguments)),
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

class AppContent extends StatelessWidget {
  final AppTheme theme;
  final Widget screen;

  const AppContent({Key key, @required this.screen, @required this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set the fit size (fill in the screen size of the device in the design)
    // https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
    // Size of iPhone 8: 375 × 667 (points) - 750 × 1334 (pixels) (2x)
    ScreenUtil.init(context, width: 375, height: 667, allowFontScaling: false);
    WidgetsBinding.instance.addPostFrameCallback((_) => onAfterBuild(context));

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.transparent,
      body: AnnotatedRegion(
        value: theme.isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        child: AppBarPadding(
          backgroundColor: theme.headerBgColor,
          child: SafeArea(
            bottom: false,
            child: screen,
          ),
        ),
      ),
    );
  }

  // After widget initialized.
  void onAfterBuild(BuildContext context) {}
}
