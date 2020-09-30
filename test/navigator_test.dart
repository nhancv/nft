import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/my_app.dart';
import 'package:nft/pages/counter/counter_page.dart';
import 'package:nft/pages/home/home_page.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/services/app_loading.dart';
import 'package:nft/services/remote/auth_api.dart';
import 'package:nft/utils/app_config.dart';
import 'package:nft/utils/app_constant.dart';
import 'package:nft/utils/app_route.dart';
import 'package:nft/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  // Mock navigator to verify navigation
  final MockNavigatorObserver navigatorObserver = MockNavigatorObserver();

  // Widget to test
  Widget appWidget;

  /// Setup for test
  setUp(() {
    Config(environment: Env.dev());

    // Testing in flutter gives error MediaQuery.of() called
    // with a context that does not contain a MediaQuery
    appWidget = MediaQuery(
      data: const MediaQueryData(),
      child: MultiProvider(
        providers: <SingleChildWidget>[
          Provider<AppRoute>(create: (_) => AppRoute()),
          Provider<AuthApi>(create: (_) => AuthApi()),
          Provider<AppLoadingProvider>(create: (_) => AppLoadingProvider()),
          ChangeNotifierProvider<LocaleProvider>(
              create: (_) => LocaleProvider()),
          ChangeNotifierProvider<AppThemeProvider>(
              create: (_) => AppThemeProvider()),
          ChangeNotifierProvider<HomeProvider>(
              create: (BuildContext context) =>
                  HomeProvider(context.read<AuthApi>())),
        ],
        child: Builder(
          builder: (BuildContext context) {
            final LocaleProvider localeProvider =
                context.watch<LocaleProvider>();
            final AppRoute appRoute = context.watch<AppRoute>();

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
              initialRoute: AppConstant.rootPageRoute,
              onGenerateRoute: appRoute.generateRoute,
              navigatorObservers: <NavigatorObserver>[navigatorObserver],
            );
          },
        ),
      ),
    );
  });

  /// Test case:
  /// - Tap on Counter Page button
  /// - App navigate from HomePage to CounterPage
  testWidgets('Navigate from HomePage to CounterPage',
      (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    // Build a MaterialApp with MediaQuery.
    await tester.pumpWidget(appWidget);
    // Wait the widget state updated until the LocalizationsDelegate initialized.
    await tester.pumpAndSettle();

    // Verify that HomePage displayed
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);

    // Verify that RaisedButton on screen
    const Key counterPageBtnKey = Key(AppConstant.counterPageRoute);
    final Finder counterPageFinder = find.byKey(counterPageBtnKey);
    expect(counterPageFinder, findsOneWidget);

    // Tap on RaisedButton
    await tester.tap(counterPageFinder);

    // Wait the widget state updated until the dismiss animation ends.
    await tester.pumpAndSettle();

    // Verify that a push event happened
    verify(navigatorObserver.didPush(any, any));

    // Verify that CounterPage opened
    expect(find.byType(CounterPage), findsOneWidget);
  });
}
