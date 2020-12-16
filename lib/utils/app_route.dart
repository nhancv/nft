import 'package:flutter/material.dart';
import 'package:nft/pages/counter/counter_page.dart';
import 'package:nft/pages/home/home_page.dart';
import 'package:nft/pages/login/login_page.dart';
import 'package:provider/provider.dart';

class AppRoute {
  //#region ROUTE NAMES
  // -----------------
  static const String routeRoot = '/';
  static const String routeHome = '/home';
  static const String routeLogin = '/login';
  static const String routeCounter = '/counter';

  //#endregion

  /// App global navigator key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // App route observer
  final RouteObserver<Route<dynamic>> routeObserver =
      RouteObserver<Route<dynamic>>();

  // Get app context
  BuildContext get appContext => navigatorKey.currentContext;

  /// Generate route for app here
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeCounter:
        return MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (_) =>
                CounterPage(argument: settings.arguments as String));

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
    return Provider.of<AppRoute>(this, listen: false);
  }

  NavigatorState navigator() {
    return route().navigatorKey.currentState;
  }
}
