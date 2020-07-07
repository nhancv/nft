import 'package:flutter/foundation.dart';

class Logging {
  static void log(dynamic data) {
    // ignore: avoid_print
    if (!kReleaseMode) print(data);
  }
}
