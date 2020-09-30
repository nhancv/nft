import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/my_app.dart';
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

/// Mock navigator observer class by mockito
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

/// Mock Rest api class by mockito
class MockAuthApi extends Mock implements AuthApi {}

void main() {
  // Mock navigator to verify navigation
  final MockNavigatorObserver navigatorObserver = MockNavigatorObserver();

  // Mock class refs
  AuthApi authApi;
  HomeProvider homeProvider;

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
          Provider<AuthApi>(create: (_) => MockAuthApi()),
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
            // Save provider ref here
            authApi = context.watch<AuthApi>();
            homeProvider = context.watch<HomeProvider>();

            // Use Mockito to return a successful response when it calls the
            // signIn function
            when(authApi.signIn()).thenAnswer((_) {
              return Future<Response<dynamic>>.value(
                Response<dynamic>(
                  data: <String, dynamic>{
                    'data': <String, String>{
                      'access_token': 'nhancvdeptrai',
                    },
                  },
                ),
              );
            });

            // Get providers
            final LocaleProvider localeProvider =
                context.watch<LocaleProvider>();
            final AppRoute appRoute = context.watch<AppRoute>();
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
  /// - Tap on Call Api button
  /// - App should display api result
  testWidgets('Call api from HomePage', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    // Build a MaterialApp with MediaQuery.
    await tester.pumpWidget(appWidget);
    // Wait the widget state updated until the LocalizationsDelegate initialized.
    await tester.pumpAndSettle();

    // Verify that HomePage displayed
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);

    // Verify that RaisedButton on screen
    const Key callApiBtnKey = Key('callApiBtnKey');
    final Finder callApiFinder = find.byKey(callApiBtnKey);
    expect(callApiFinder, findsOneWidget);

    // Tap on RaisedButton
    await tester.tap(callApiFinder);

    // Wait the widget state updated until the dismiss animation ends.
    await tester.pumpAndSettle();

    // Verify that login function called
    verify(authApi.signIn());

    // Verify that result show on screen
    const String res =
        '{data: {tokenType: null, expiresIn: null, accessToken: nhancvdeptrai, refreshToken: null}, error: null}';
    // Verify response data of provider is correct
    expect(homeProvider.response, res);
    // Verify response data display is correct
    expect(find.text(res), findsOneWidget);
  });
}
