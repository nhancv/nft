import 'package:flutter_driver/driver_extension.dart';
import 'package:nft/main.dart' as app;

/// https://flutter.dev/docs/cookbook/testing/integration/introduction
/// Run integration test: flutter drive --target=test_driver/app.dart
/// flutter drive --target=test_driver/app.dart --driver=test_driver/app_test.dart
void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}
