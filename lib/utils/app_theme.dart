import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  final bool isDark;
  final headerBgColor;
  final backgroundColor;

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
    this.backgroundColor = const Color(0x08979797),
    this.headerBgColor = const Color(0xFFF8F7F7),
  });
}

class AppThemeProvider with ChangeNotifier {
  AppTheme theme = AppTheme.dark();

  void updateAppTheme(AppTheme appTheme) {
    theme = appTheme;
    notifyListeners();
  }

}
