import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:nft/my_app.dart';
import 'package:nft/utils/app_config.dart';

Future<void> main() async {
  /// Init dev config
  Config(environment: Env.dev());

  // Initialize Crash report
  Crashlytics.instance.enableInDevMode = true;
  // Pass all uncaught errors to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runZoned(() async {
    await myMain();
  }, onError: Crashlytics.instance.recordError);
}
