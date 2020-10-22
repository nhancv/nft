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
    this.primaryColor = Colors.blueGrey,
    this.accentColor = Colors.blueGrey,
    this.backgroundColor = const Color(0xFFF2F2F2),
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
      primaryColor: primaryColor,
      accentColor: accentColor,
      fontFamily: AppFonts.roboto,
      pageTransitionsTheme: _buildPageTransitionsTheme(),
      buttonTheme: _buildButtonTheme(),
      textTheme: _buildTextTheme(),
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

  // Custom button theme full width
  ButtonThemeData _buildButtonTheme() {
    return ButtonThemeData(
      minWidth: double.infinity,
      shape: const Border(),
      buttonColor: accentColor,
      textTheme: ButtonTextTheme.primary,
      padding: const EdgeInsets.all(16),
    );
  }

  // Custom text theme
  TextTheme _buildTextTheme() {
    return const TextTheme();
  }
}

class AppThemeProvider with ChangeNotifier {
  AppTheme _theme = const AppTheme.dark();

  AppTheme get theme => _theme;

  set theme(AppTheme value) {
    _theme = value;
    notifyListeners();
  }
}

extension AppThemeExt on BuildContext {
  AppTheme theme() {
    return watch<AppThemeProvider>().theme;
  }
}
