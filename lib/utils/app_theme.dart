import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTheme {
  final bool isDark;
  final Color headerBgColor;
  final Color backgroundColor;

  const AppTheme({
    @required this.isDark,
    @required this.backgroundColor,
    @required this.headerBgColor,
  });

  const AppTheme.dark({
    this.isDark = true,
    this.backgroundColor = Colors.black,
    this.headerBgColor = const Color(0xFF191819),
  });

  const AppTheme.light({
    this.isDark = false,
    this.backgroundColor = Colors.white,
    this.headerBgColor = const Color(0xFFF8F7F7),
  });
}

class AppThemeProvider with ChangeNotifier {
  AppTheme theme = AppTheme.light();

  void updateAppTheme(AppTheme appTheme) {
    theme = appTheme;
    notifyListeners();
  }

}

extension AppThemeExt on BuildContext {
  AppTheme theme() {
    return this.watch<AppThemeProvider>().theme;
  }
}