import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nft/main.dart' as app;
import 'package:nft/services/app/app_route.dart';

/// https://flutter.dev/docs/cookbook/testing/integration/introduction
/// Run integration test:
/// - Mobile & Desktop
/// flutter test integration_test/app_test.dart
/// - Web:
/// Launch chromedriver as follows:
/// * Download ChromeDriver at: https://chromedriver.chromium.org/downloads
/// chromedriver --port=4444
/// flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart -d chrome
///
void main() {
  // This line enables the extension.
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Empty', () {
    testWidgets('empty', (WidgetTester tester) async {
      // Call the `main()` function of the app, or call `runApp` with
      // any widget you are interested in testing.
      app.main();
      await tester.pumpAndSettle();
    });
  });

  group('Counter App', () {
    testWidgets('tap on the floating action button, verify counter', (WidgetTester tester) async {
      // Call the `main()` function of the app, or call `runApp` with
      // any widget you are interested in testing.
      app.main();
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      // At LOGIN screen
      // Login with email & password
      await tester.enterText(find.byKey(const Key('emailInputKey')), 'app@gmail.com');
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key('passwordInputKey')), '123');
      await tester.pumpAndSettle();
      // Close keyboard
      FocusManager.instance.primaryFocus?.unfocus();
      await tester.pumpAndSettle(const Duration(milliseconds: 500));

      // Wait to HOME screen
      await tester.tap(find.byKey(const Key('callApiBtnKey')));
      await tester.pumpAndSettle(const Duration(milliseconds: 3000));

      // At HOME screen
      // Navigate to COUNTER screen
      await tester.tap(find.byKey(const Key(AppRoute.routeCounter)));
      await tester.pumpAndSettle();

      // Verify the counter starts at 0.
      expect(find.text('0'), findsOneWidget);

      // Finds the floating action button to tap on.
      final Finder fab = find.byTooltip('Increment');
      // Emulate a tap on the floating action button.
      await tester.tap(fab);
      await tester.pumpAndSettle();

      // Verify the counter increments by 1.
      expect(find.text('1'), findsOneWidget);
    });
  });
}
