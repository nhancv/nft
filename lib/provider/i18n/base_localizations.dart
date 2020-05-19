
/*
 * MIT License
 *
 * Copyright (c) 2020 Nhan Cao
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

abstract class BaseLocalizations {
  final Locale locale;

  BaseLocalizations(this.locale) {
    _localizedStrings = load(this.locale);
  }

  Map<String, String> _localizedStrings;

  Map<String, String> load(Locale locale);

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings[key];
  }
}

typedef S ItemCreator<S>(locale);

class AppLocalizationsDelegate<T extends BaseLocalizations>
    extends LocalizationsDelegate<T> {
  final langSupportedList;
  final ItemCreator<T> creator;

  // Ex: AppLocalizationsDelegate(['en', 'vi'], (locale) => DefaultLocalizations(locale))
  const AppLocalizationsDelegate(this.langSupportedList, this.creator);

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return langSupportedList.contains(locale.languageCode);
  }

  @override
  Future<T> load(Locale locale) {
    return SynchronousFuture<T>(creator(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate<T> old) => false;
}

class DefaultLocalizations extends BaseLocalizations {
  // Just a default language packages,
  // in project you should create separated dar language files
  final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title': 'Hello',
    },
    'vi': {
      'title': 'Xin chào',
    }
  };

  DefaultLocalizations(Locale locale) : super(locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static DefaultLocalizations of(BuildContext context) {
    return Localizations.of<DefaultLocalizations>(
        context, DefaultLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static LocalizationsDelegate<DefaultLocalizations> delegate =
      AppLocalizationsDelegate(
          ['en', 'vi'], (locale) => DefaultLocalizations(locale));

  @override
  Map<String, String> load(Locale locale) {
    switch (locale.languageCode) {
      case 'vi':
        return _localizedValues['vi'];
    }
    return _localizedValues['en'];
  }
}
