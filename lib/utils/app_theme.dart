import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTheme {
  final bool isDark;
  final Color backgroundColor;

  const AppTheme({
    @required this.isDark,
    @required this.backgroundColor,
  });

  const AppTheme.dark({
    this.isDark = true,
    this.backgroundColor = Colors.black,
  });

  const AppTheme.light({
    this.isDark = false,
    this.backgroundColor = Colors.white,
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
