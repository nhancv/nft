import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/pages/home/home_page.dart';
import 'package:nft/pages/login/login_page.dart';
import 'package:nft/services/apis/api_user.dart';
import 'package:nft/services/app/app_config.dart';
import 'package:nft/services/app/app_route.dart';
import 'package:nft/services/app/app_theme.dart';
import 'package:nft/services/cache/credential.dart';
import 'package:nft/services/providers/provider_locale.dart';
import 'package:nft/services/providers/providers.dart';
import 'package:nft/utils/app_loading.dart';
import 'package:nft/utils/app_log.dart';

/// Mock navigator observer class by mockito
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

// Fake Route
class FakeRoute extends Fake implements Route<dynamic> {}

// Fake BuildContext
class FakeBuildContext extends Fake implements BuildContext {}

/// Mock Credential
class MockCredential extends Mock implements Credential {}

/// Mock Rest api class by mockito
class MockAuthApi extends Mock implements ApiUser {}

/// Mock App loading dialog
class MockAppLoading extends Mock implements AppLoading {}

// Mock navigator to verify navigation
final MockNavigatorObserver navigatorObserver = MockNavigatorObserver();

// Mock class refs
late ApiUser userApi;
late AppRoute appRoute;
late AppLoading appLoading;

const String email = 'test@gmail.com';
const String pwd = '123';

// My App https://docs-v2.riverpod.dev/docs/cookbooks/testing
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Get providers
    final LocaleProvider localeProvider = ref.watch(pLocaleProvider);
    final AppTheme appTheme = ref.watch(pAppThemeProvider).theme;
    appRoute = ref.watch(pAppRouteProvider);
    appLoading = ref.watch(pAppLoadingProvider);
    userApi = ref.watch(pApiUserProvider);

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
        initialRoute: AppRoute.routeLogin,
        onGenerateRoute: appRoute.generateRoute,
        navigatorObservers: <NavigatorObserver>[navigatorObserver],
      ),
    );
  }
}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeRoute());
    registerFallbackValue(FakeBuildContext());
  });

  /// Setup for test
  setUp(() {
    AppConfig(env: Env.dev());

    // Mock navigator Observer
    when(() => navigatorObserver.didPush(any(), any())).thenAnswer((Invocation invocation) {
      logger.d('didPush ${invocation.positionalArguments}');
    });
  });

  /// Test case:
  /// - Tap on Call Api button
  /// - App navigate to HomePage after login
  testWidgets('Call login api and navigate to HomePage afterward', (WidgetTester tester) async {
    /// MOCK value classes

    final mockLoading = MockAppLoading();
    // Fix: type 'Null' is not a subtype of type 'Future<void>'
    when<Future<void>>(() => mockLoading.showLoading(any())).thenAnswer((_) async {});
    when<void>(() => mockLoading.hideLoading()).thenAnswer((_) {});

    // Use Mockito to return a successful response when it calls the signIn function
    final mockApi = MockAuthApi();
    when(() => mockApi.logIn(email, pwd)).thenAnswer((_) {
      return Future<Response<Map<String, dynamic>>>.value(
        Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(path: ''),
          data: <String, dynamic>{
            'data': <String, String>{
              'access_token': 'nhancvdeptrai',
            },
          },
        ),
      );
    });

    final pMockCredential = (ChangeNotifierProviderRef<Credential> ref) {
      final mock = MockCredential();
      when<Future<bool>>(() => mock.storeCredential(any(), cache: any(named: 'cache'))).thenAnswer((_) async {
        return true;
      });
      return mock;
    };

    // Create the widget by telling the tester to build it.
    // Build a MaterialApp with MediaQuery.
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pAppLoadingProvider.overrideWithValue(mockLoading),
          pApiUserProvider.overrideWithValue(mockApi),
          pCredentialProvider.overrideWith(pMockCredential),
        ],
        child: MyApp(),
      ),
    );
    // Wait the widget state updated until the LocalizationsDelegate initialized.
    await tester.pumpAndSettle();

    // Verify that LoginPage displayed
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(LoginPage), findsOneWidget);

    // Fill login form
    logger.d('Fill login form');
    final Finder emailInputFinder = find.byKey(const Key('emailInputKey'));
    final Finder passwordInputFinder = find.byKey(const Key('passwordInputKey'));
    expect(emailInputFinder, findsOneWidget);
    expect(passwordInputFinder, findsOneWidget);
    await tester.enterText(emailInputFinder, email);
    await tester.enterText(passwordInputFinder, pwd);
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
    final ElevatedButton button = callApiFinder.evaluate().first.widget as ElevatedButton;
    button.onPressed!();
    await tester.pumpAndSettle();

    // Verify
    logger.d('Verifying');
    // Verify push to show loading
    verify(() => appLoading.showLoading(any())).called(1);
    // Verify that login function called
    verify(() => userApi.logIn(email, pwd));
    //  Verify push to hide loading
    verify(() => appLoading.hideAppDialog());

    // Wait the widget state updated
    await tester.pumpAndSettle();

    // Verify that a push event happened
    verify(() => navigatorObserver.didPush(any(), any()));
    // Verify that HomePage opened
    expect(find.byType(HomePage), findsOneWidget);
  });
}
