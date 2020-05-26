
import 'package:flutter/widgets.dart';
import 'base_localizations.dart';
import 'en.dart';
import 'vi.dart';

class AppLocalizations extends BaseLocalizations {
  AppLocalizations(locale) : super(locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static LocalizationsDelegate<AppLocalizations> delegate =
  AppLocalizationsDelegate(
      ['en', 'vi'], (locale) => AppLocalizations(locale));

  @override
  Map<String, String> load(Locale locale) {
    switch (locale.languageCode) {
      case 'vi':
        return vi;
    }
    return en;
  }
}