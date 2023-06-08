import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/pages/counter/counter_page.dart';
import 'package:nft/pages/home/home_page.dart';
import 'package:nft/services/app/app_config.dart';
import 'package:nft/services/app/app_route.dart';
import 'package:nft/services/app/app_theme.dart';
import 'package:nft/services/providers/provider_locale.dart';
import 'package:nft/services/providers/providers.dart';
import 'package:nft/utils/app_log.dart';

/// Mock navigator observer class by mockito
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

// Fake Route for mocktail
class FakeRoute extends Fake implements Route<dynamic> {}

// Mock navigator to verify navigation
final MockNavigatorObserver navigatorObserver = MockNavigatorObserver();

// My App https://docs-v2.riverpod.dev/docs/cookbooks/testing
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Get providers
    final AppRoute appRoute = AppRoute.I;
    final LocaleProvider localeProvider = ref.watch(pLocaleProvider);
    final AppTheme appTheme = ref.watch(pAppThemeProvider).theme;

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
        initialRoute: AppRoute.routeHome,
        onGenerateRoute: appRoute.generateRoute,
        navigatorObservers: <NavigatorObserver>[navigatorObserver],
      ),
    );
  }
}

void main() {
  /// Setup for tests
  setUpAll(() {
    registerFallbackValue(FakeRoute());
    AppConfig(env: Env.dev());

    // Mock navigator Observer
    when(() => navigatorObserver.didPush(any(), any())).thenAnswer((Invocation invocation) {
      logger.d('didPush ${invocation.positionalArguments}');
    });
  });

  /// Test case:
  /// - Tap on Counter Page button
  /// - App navigate from HomePage to CounterPage
  testWidgets('Navigate from HomePage to CounterPage', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    // Build a MaterialApp with MediaQuery.
    await tester.pumpWidget(ProviderScope(child: MyApp()));
    // Wait the widget state updated until the LocalizationsDelegate initialized.
    await tester.pumpAndSettle();

    // Verify that HomePage displayed
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);

    // Verify that RaisedButton on screen
    final Finder counterPageFinder = find.byKey(const Key(AppRoute.routeCounter));
    expect(counterPageFinder, findsOneWidget);

    // Tap on RaisedButton
    await tester.tap(counterPageFinder);

    // Wait the widget state updated until the dismiss animation ends.
    await tester.pumpAndSettle();

    // Verify that a push event happened
    verify(() => navigatorObserver.didPush(any(), any()));

    // Verify that CounterPage opened
    expect(find.byType(CounterPage), findsOneWidget);
  });
}
