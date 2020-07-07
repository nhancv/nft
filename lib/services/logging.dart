import 'package:flutter/foundation.dart';

class Logging {
  static void log(dynamic data) {
    if (!kReleaseMode) {
      // ignore: avoid_print
      print(data);
    }
  }
}
