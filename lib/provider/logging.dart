import 'package:flutter/foundation.dart';

class Logging {
  static int tet;

  static void log(dynamic data) {
    if (!kReleaseMode) print(data);
  }
}
