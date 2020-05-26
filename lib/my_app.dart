
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:nft/pages/home/home_screen.dart';
import 'package:nft/provider/i18n/app_localizations.dart';
import 'package:nft/provider/local_storage.dart';
import 'package:nft/utils/app_asset.dart';
import 'package:nft/widgets/appbar_padding.dart';

final getIt = GetIt.instance;

void diSetup() {
  getIt.registerSingleton<LocalStorage>(LocalStorage());
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
        BlocProvider<LocaleBloc>(
          create: (BuildContext context) => LocaleBloc(),
        ),
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
            home: AppContent(),
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
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => onAfterBuild(context));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark,
        child: AppBarPadding(
          child: HomeScreen(),
        ),
      ),
    );
  }

  // After widget initialized.
  void onAfterBuild(BuildContext context) {}
}
