import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  /// Save locale
  Locale _locale = Locale(ui.window.locale.languageCode);

  /// Get current locale
  Locale get locale => _locale;

  /// Update new locale
  set locale(Locale value) {
    _locale = value;
    notifyListeners();
  }
}
