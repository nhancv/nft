import 'dart:io';

/// How to use: override http client global before run app
/// void main() {
///   HttpOverrides.global = SelfSignedHttps();
///   runApp(MyApp());
/// }

class SelfSignedHttps extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    final HttpClient client = super.createHttpClient(context);
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return client;
  }
}
