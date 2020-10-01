import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTheme {
  const AppTheme({
    @required this.isDark,
    @required this.backgroundColor,
    @required this.headerBgColor,
  });

  /// Dart theme
  const AppTheme.dark({
    this.isDark = true,
    this.backgroundColor = Colors.black,
    this.headerBgColor = Colors.black,
  });

  /// Light theme
  const AppTheme.light({
    this.isDark = false,
    this.backgroundColor = Colors.white,
    this.headerBgColor = Colors.white,
  });

  final bool isDark;
  final Color backgroundColor;
  final Color headerBgColor;
}

class AppThemeProvider with ChangeNotifier {
  AppTheme theme = const AppTheme.light();

  void updateAppTheme(AppTheme appTheme) {
    theme = appTheme;
    notifyListeners();
  }
}

extension AppThemeExt on BuildContext {
  AppTheme theme() {
    return watch<AppThemeProvider>().theme;
  }
}
