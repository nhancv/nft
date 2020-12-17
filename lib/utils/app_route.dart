import 'package:flutter/material.dart';
import 'package:nft/pages/counter/counter_page.dart';
import 'package:nft/pages/home/home_page.dart';
import 'package:nft/pages/login/login_page.dart';
import 'package:provider/provider.dart';

class AppRoute {
  factory AppRoute() => _instance;

  AppRoute._private();

  ///#region ROUTE NAMES
  /// -----------------
  static const String routeRoot = '/';
  static const String routeHome = '/home';
  static const String routeLogin = '/login';
  static const String routeCounter = '/counter';

  ///#endregion

  static final AppRoute _instance = AppRoute._private();

  static AppRoute get I => _instance;

  /// App route observer
  final RouteObserver<Route<dynamic>> routeObserver =
      RouteObserver<Route<dynamic>>();

  /// App global navigator key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Get app context
  BuildContext get appContext => navigatorKey.currentContext;

  /// Generate route for app here
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeCounter:
        return MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (_) => CounterPage.create(argument: settings.arguments));

      case routeHome:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => const HomePage());

      case AppRoute.routeLogin:
      case AppRoute.routeRoot:
      default:
        return MaterialPageRoute<dynamic>(
            settings: settings, builder: (_) => const LoginPage());
    }
  }
}

extension AppRouteExt on BuildContext {
  AppRoute route() {
    return Provider.of(this, listen: false);
  }

  NavigatorState navigator() {
    return route().navigatorKey.currentState;
  }
}
