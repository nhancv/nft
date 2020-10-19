import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nft/utils/app_asset.dart';
import 'package:provider/provider.dart';

class AppTheme {
  const AppTheme({
    @required this.isDark,
    @required this.primaryColor,
    @required this.accentColor,
    @required this.backgroundColor,
    @required this.headerBgColor,
  });

  /// Dart theme
  const AppTheme.dark({
    this.isDark = true,
    this.primaryColor = Colors.black,
    this.accentColor = Colors.black,
    this.backgroundColor = Colors.black,
    this.headerBgColor = Colors.black,
  });

  /// Light theme
  const AppTheme.light({
    this.isDark = false,
    this.primaryColor = Colors.white,
    this.accentColor = Colors.white,
    this.backgroundColor = Colors.white,
    this.headerBgColor = Colors.white,
  });

  final bool isDark;
  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;
  final Color headerBgColor;

  // Build theme data
  ThemeData buildThemeData() {
    return ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primaryColor: primaryColor,
        accentColor: accentColor,
        fontFamily: AppFonts.roboto,
        pageTransitionsTheme: _buildPageTransitionsTheme()
    );
  }

  /// Custom page transitions theme
  PageTransitionsTheme _buildPageTransitionsTheme() {
    return const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder(),
      },
    );
  }
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
