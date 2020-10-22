import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/models/local/token.dart';
import 'package:nft/my_app.dart';
import 'package:nft/pages/home/home_page.dart';
import 'package:nft/pages/home/home_provider.dart';
import 'package:nft/pages/login/login_page.dart';
import 'package:nft/pages/login/login_provider.dart';
import 'package:nft/services/app_loading.dart';
import 'package:nft/services/local/credential.dart';
import 'package:nft/services/local/storage.dart';
import 'package:nft/services/local/storage_preferences.dart';
import 'package:nft/services/remote/user_api.dart';
import 'package:nft/utils/app_config.dart';
import 'package:nft/utils/app_constant.dart';
import 'package:nft/utils/app_log.dart';
import 'package:nft/utils/app_route.dart';
import 'package:nft/utils/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// Mock navigator observer class by mockito
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

/// Mock Credential
class MockCredential extends Mock implements Credential {
  @override
  Future<bool> storeCredential(final Token token, {bool cache = false}) async {
    return true;
  }
}

/// Mock Rest api class by mockito
class MockAuthApi extends Mock implements UserApi {}

/// Mock App loading dialog
class MockAppLoadingProvider extends Mock implements AppLoadingProvider {}

void main() {
  // Mock navigator to verify navigation
  final MockNavigatorObserver navigatorObserver = MockNavigatorObserver();

  // Mock class refs
  UserApi userApi;
  AppRoute appRoute;
  LoginProvider loginProvider;
  AppLoadingProvider appLoadingProvider;

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
          Provider<Storage>(create: (_) => StoragePreferences()),
          ChangeNotifierProvider<Credential>(
              create: (BuildContext context) => MockCredential()),
          ProxyProvider<Credential, UserApi>(
              create: (_) => MockAuthApi(),
              update: (_, Credential credential, UserApi userApi) {
                return userApi..token = credential.token;
              }),
          Provider<AppLoadingProvider>(create: (_) => MockAppLoadingProvider()),
          ChangeNotifierProvider<LocaleProvider>(
              create: (_) => LocaleProvider()),
          ChangeNotifierProvider<AppThemeProvider>(
              create: (_) => AppThemeProvider()),
          ChangeNotifierProvider<HomeProvider>(
              create: (BuildContext context) => HomeProvider(
                    context.read<UserApi>(),
                    context.read<Credential>(),
                  )),
          ChangeNotifierProvider<LoginProvider>(
              create: (BuildContext context) => LoginProvider(
                    context.read<UserApi>(),
                    context.read<Credential>(),
                  )),
        ],
        child: Builder(
          builder: (BuildContext context) {
            // Save provider ref here
            userApi = context.watch<UserApi>();
            appRoute = context.watch<AppRoute>();
            loginProvider = context.watch<LoginProvider>();
            appLoadingProvider = context.watch<AppLoadingProvider>();

            // Mock navigator Observer
            when(navigatorObserver.didPush(any, any))
                .thenAnswer((Invocation invocation) {
              logger.d('didPush ${invocation.positionalArguments}');
            });

            // Use Mockito to return a successful response when it calls the
            // signIn function
            when(userApi.logIn()).thenAnswer((_) {
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
                          const RouteSettings(name: AppConstant.loginPageRoute))
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
    await tester.enterText(
        find.byKey(const Key('emailInputKey')), 'test@gm.com');
    await tester.enterText(find.byKey(const Key('passwordInputKey')), '123');
    // Wait the widget state updated until the dismiss animation ends.
    await tester.pumpAndSettle();

    // Verify that RaisedButton on screen
    // Tap on RaisedButton
    logger.d('Tap login');
    final Finder callApiFinder = find.byKey(const Key('callApiBtnKey'));
    expect(callApiFinder, findsOneWidget);
    await tester.tap(callApiFinder);

    // Verify
    logger.d('Verifying');
    // Verify push to show loading
    verify(appLoadingProvider.showLoading(any));
    // Verify that login function called
    verify(userApi.logIn());
    //  Verify push to hide loading
    verify(appLoadingProvider.hideLoading());

    // Wait the widget state updated
    await tester.pumpAndSettle();

    // Verify that a push event happened
    verify(navigatorObserver.didPush(any, any));
    // Verify that HomePage opened
    expect(find.byType(HomePage), findsOneWidget);
  });
}
