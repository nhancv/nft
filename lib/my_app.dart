import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/pages/home/home_screen.dart';
import 'package:nft/provider/i18n/app_localizations.dart';
import 'package:nft/provider/local_storage.dart';
import 'package:nft/provider/remote/auth_api.dart';
import 'package:nft/utils/app_asset.dart';
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
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                HomeProvider(Provider.of<AuthApi>(context, listen: false))),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            locale: value.locale,
            supportedLocales: [
              const Locale('en'),
              const Locale('vi'),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.blue, fontFamily: AppFonts.roboto),
            initialRoute: '/',
            onGenerateRoute: (RouteSettings settings) {
              switch (settings.name) {
//                case AppConstant.anotherRouteName:
//                  return FadeRoute(page: AppContent(screen: AnotherScreen()));
              }
              return FadeRoute(page: AppContent(screen: HomeScreen()));
            },
          );
        },
      ),
    );
  }
}

class LocaleProvider with ChangeNotifier {
  Locale locale = Locale(ui.window.locale?.languageCode ?? ' en');

  void updateLocale(Locale locale) {
    this.locale = locale;
    notifyListeners();
  }
}

class AppContent extends StatelessWidget {
  final Widget screen;

  const AppContent({Key key, @required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Set the fit size (fill in the screen size of the device in the design)
    // https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
    // Size of iPhone 8: 375 × 667 (points) - 750 × 1334 (pixels) (2x)
    ScreenUtil.init(context, width: 375, height: 667, allowFontScaling: false);
    WidgetsBinding.instance.addPostFrameCallback((_) => onAfterBuild(context));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: AppBarPadding(
          child: screen,
        ),
      ),
    );
  }

  // After widget initialized.
  void onAfterBuild(BuildContext context) {}
}

class FadeRoute<T> extends MaterialPageRoute<T> {
  FadeRoute({Widget page, RouteSettings settings})
      : super(builder: (_) => page, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return new FadeTransition(opacity: animation, child: child);
  }
}
