import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:nft/pages/home/home_bloc.dart';
import 'package:nft/pages/home/home_screen.dart';
import 'package:nft/provider/i18n/app_localizations.dart';
import 'package:nft/provider/local_storage.dart';
import 'package:nft/provider/remote/auth_api.dart';
import 'package:nft/utils/app_asset.dart';
import 'package:nft/widgets/appbar_padding.dart';

final getIt = GetIt.instance;

void diSetup() {
  getIt.registerSingleton<LocalStorage>(LocalStorage());
  //usage:
  //GetIt.I<LocalStorage>();
  getIt.registerSingleton<AuthApi>(AuthApi());
}

Future<void> myMain() async {
  // Start services later
  WidgetsFlutterBinding.ensureInitialized();

  // Get it setup
  diSetup();

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => LocaleBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => HomeBloc(),
        )
      ],
      child: BlocBuilder<LocaleBloc, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            locale: locale,
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

class LocaleBloc extends Bloc<Locale, Locale> {
  @override
  get initialState => Locale(ui.window.locale?.languageCode ?? ' en');

  @override
  Stream<Locale> mapEventToState(Locale event) async* {
    yield event;
  }
}

class AppContent extends StatelessWidget {
  final Widget screen;

  const AppContent({Key key, @required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
