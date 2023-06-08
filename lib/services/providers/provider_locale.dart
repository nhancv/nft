import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  /// Save locale
  Locale _locale = const Locale('en', 'US');

  /// Get current locale
  Locale get locale => _locale;

  /// Update new locale
  set locale(Locale value) {
    _locale = value;
    notifyListeners();
  }
}
