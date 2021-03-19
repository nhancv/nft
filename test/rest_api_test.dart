import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/models/local/token.dart';
import 'package:nft/pages/home/home_page.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/pages/login/login_page.dart';
import 'package:nft/pages/login/login_provider.dart';
import 'package:nft/services/app/app_loading.dart';
import 'package:nft/services/app/auth_provider.dart';
import 'package:nft/services/app/locale_provider.dart';
import 'package:nft/services/cache/cache.dart';
import 'package:nft/services/cache/cache_preferences.dart';
import 'package:nft/services/cache/credential.dart';
import 'package:nft/services/rest_api/api_user.dart';
import 'package:nft/utils/app_config.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/utils/app_route.dart';
import 'package:nft/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// Mock navigator observer class by mockito
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

/// Mock Credential
class MockCredential extends Credential {
  MockCredential(Cache storage) : super(storage);

  @override
  Future<bool> storeCredential(final Token token, {bool cache = false}) async {
    return true;
  }
}

/// Mock Rest api class by mockito
class MockAuthApi extends Mock implements ApiUser {}

/// Mock App loading dialog
class MockAppLoading extends Mock implements AppLoading {}

void main() {
  // Mock navigator to verify navigation
  final MockNavigatorObserver navigatorObserver = MockNavigatorObserver();

  // Mock class refs
  ApiUser userApi;
  AppRoute appRoute;
  AppLoading appLoading;

  // Widget to test
  Widget appWidget;

  /// Setup for test
  setUp(() {
    AppConfig(env: Env.dev());

    // Testing in flutter gives error MediaQuery.of() called
    // with a context that does not contain a MediaQuery
    appWidget = MediaQuery(
      data: const MediaQueryData(),
      child: MultiProvider(
        providers: <SingleChildWidget>[
          Provider<AppRoute>(create: (_) => AppRoute()),
          Provider<Cache>(create: (_) => CachePreferences()),
          ChangeNotifierProvider<Credential>(
              create: (BuildContext context) => MockCredential(
                    context.read<Cache>(),
                  )),
          ProxyProvider<Credential, ApiUser>(
              create: (_) => MockAuthApi(),
              update: (_, Credential credential, ApiUser userApi) {
                return userApi..token = credential.token;
              }),
          Provider<AppLoading>(create: (_) => MockAppLoading()),
          ChangeNotifierProvider<LocaleProvider>(
              create: (_) => LocaleProvider()),
          ChangeNotifierProvider<AppThemeProvider>(
              create: (_) => AppThemeProvider()),
          ChangeNotifierProvider<AuthProvider>(
              create: (BuildContext context) => AuthProvider(
                    context.read<ApiUser>(),
                    context.read<Credential>(),
                  )),
          ChangeNotifierProvider<HomeProvider>(
              create: (BuildContext context) => HomeProvider(
                    context.read<ApiUser>(),
                  )),
          ChangeNotifierProvider<LoginProvider>(
              create: (BuildContext context) => LoginProvider()),
        ],
        child: Builder(
          builder: (BuildContext context) {
            // Save provider ref here
            userApi = Provider.of(context, listen: false);
            appRoute = Provider.of(context, listen: false);
            appLoading = Provider.of(context, listen: false);

            // Mock navigator Observer
            when(navigatorObserver.didPush(any, any))
                .thenAnswer((Invocation invocation) {
              logger.d('didPush ${invocation.positionalArguments}');
            });

            // Use Mockito to return a successful response when it calls the
            // signIn function
            when(userApi.logIn(null, null)).thenAnswer((_) {
              return Future<Response<Map<String, dynamic>>>.value(
                Response<Map<String, dynamic>>(
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
              home: (appRoute.generateRoute(
                          const RouteSettings(name: AppRoute.routeLogin))
                      as MaterialPageRoute<dynamic>)
                  .builder(context),
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
  /// - App navigate to HomePage after login
  testWidgets('Call login api and navigate to HomePage afterward',
      (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    // Build a MaterialApp with MediaQuery.
    await tester.pumpWidget(appWidget);
    // Wait the widget state updated until the LocalizationsDelegate initialized.
    await tester.pumpAndSettle();

    // Verify that LoginPage displayed
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(LoginPage), findsOneWidget);

    // Fill login form
    logger.d('Fill login form');
    final Finder emailInputFinder = find.byKey(const Key('emailInputKey'));
    final Finder passwordInputFinder =
        find.byKey(const Key('passwordInputKey'));
    expect(emailInputFinder, findsOneWidget);
    expect(passwordInputFinder, findsOneWidget);
    await tester.enterText(emailInputFinder, 'test@gmail.com');
    await tester.enterText(passwordInputFinder, '123');
    // Wait the widget state updated until the dismiss animation ends.
    await tester.pumpAndSettle();

    // Verify that RaisedButton on screen
    // Tap on RaisedButton
    logger.d('Tap login');
    final Finder callApiFinder = find.widgetWithText(ElevatedButton, 'Login');
    expect(callApiFinder, findsWidgets);

    // Deal with button press:
    // tester.tap or .press does not work
    // use cast button approach instead
    final ElevatedButton button =
        callApiFinder.evaluate().first.widget as ElevatedButton;
    button.onPressed();
    await tester.pumpAndSettle();

    // Verify
    logger.d('Verifying');
    // Verify push to show loading
    verify(appLoading.showLoading(any)).called(1);
    // Verify that login function called
    verify(userApi.logIn(null, null));
    //  Verify push to hide loading
    verify(appLoading.hideAppDialog());

    // Wait the widget state updated
    await tester.pumpAndSettle();

    // Verify that a push event happened
    verify(navigatorObserver.didPush(any, any));
    // Verify that HomePage opened
    expect(find.byType(HomePage), findsOneWidget);
  });
}
