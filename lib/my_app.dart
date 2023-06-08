import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/services/app/app_route.dart';
import 'package:nft/services/app/app_theme.dart';
import 'package:nft/services/providers/provider_locale.dart';
import 'package:nft/services/providers/providers.dart';
import 'package:nft/utils/app_extension.dart';

Future<void> myMain() async {
  /// Start services later
  WidgetsFlutterBinding.ensureInitialized();

  /// Force portrait mode
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[DeviceOrientation.portraitUp]);

  /// Run Application
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();

    /// Init page route
    () async {
      final bool hasCredential = await ref.read(pCredentialProvider).loadCredential();
      if (hasCredential) {
        ref.navigator()?.pushReplacementNamed(AppRoute.routeHome);
      }
    }();
  }

  @override
  Widget build(BuildContext context) {
    /// Get providers
    final AppRoute appRoute = AppRoute.I;
    final LocaleProvider localeProvider = ref.watch(pLocaleProvider);
    final AppTheme appTheme = ref.appTheme();

    /// Init dynamic size
    /// https://pub.dev/packages/flutter_screenutil
    ///    ScreenUtil().pixelRatio       //Device pixel density
    ///    ScreenUtil().screenWidth   (sdk>=2.6 : 1.sw)    //Device width
    ///    ScreenUtil().screenHeight  (sdk>=2.6 : 1.sh)    //Device height
    ///    ScreenUtil().bottomBarHeight  //Bottom safe zone distance, suitable for buttons with full screen
    ///    ScreenUtil().statusBarHeight  //Status bar height , Notch will be higher Unit px
    ///    ScreenUtil().textScaleFactor  //System font scaling factor
    ///
    ///    ScreenUtil().scaleWidth //Ratio of actual width dp to design draft px
    ///    ScreenUtil().scaleHeight //Ratio of actual height dp to design draft px
    ///
    ///    0.2.sw  //0.2 times the screen width
    ///    0.5.sh  //50% of screen height
    /// Set the fit size (fill in the screen size of the device in the design)
    /// https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
    ///    iPhone 2, 3, 4, 4s                => 3.5": 320 x 480 (points)
    ///    iPhone 5, 5s, 5C, SE (1st Gen)    => 4": 320 × 568 (points)
    ///    iPhone 6, 6s, 7, 8, SE (2st Gen)  => 4.7": 375 x 667 (points)
    ///    iPhone 6+, 6s+, 7+, 8+            => 5.5": 414 x 736 (points)
    ///    iPhone 11Pro, X, Xs               => 5.8": 375 x 812 (points)
    ///    iPhone 11, Xr                     => 6.1": 414 × 896 (points)
    ///    iPhone 11Pro Max, Xs Max          => 6.5": 414 x 896 (points)
    ///    iPhone 12 mini                    => 5.4": 375 x 812 (points)
    ///    iPhone 12, 12 Pro                 => 6.1": 390 x 844 (points)
    ///    iPhone 12 Pro Max                 => 6.7": 428 x 926 (points)
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, __) => MaterialApp(
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
        // home: (appRoute.generateRoute(const RouteSettings(name: AppRoute.routeRoot)) as MaterialPageRoute<dynamic>)
        //     .builder(context),
        initialRoute: AppRoute.routeRoot,
        onGenerateRoute: appRoute.generateRoute,
        navigatorObservers: <NavigatorObserver>[appRoute.routeObserver],
      ),
    );
  }
}
