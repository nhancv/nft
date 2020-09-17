import 'package:flutter/material.dart';
import 'package:nft/pages/base/content_page.dart';
import 'package:nft/pages/counter/counter_page.dart';
import 'package:nft/pages/home/home_page.dart';
import 'package:nft/pages/tutorial/tutorial_page.dart';
import 'package:nft/utils/app_constant.dart';

class AppRoute {
  /// App global navigator key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // App route observer
  final RouteObserver<Route<dynamic>> routeObserver =
      RouteObserver<Route<dynamic>>();

  /// Generate route for app here
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstant.tutorialPageRoute:
        return TutorialPage(settings: settings);

      case AppConstant.counterPageRoute:
        return MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (_) => ContentPage(
                body: CounterPage(argument: settings.arguments as String)));

      case AppConstant.rootPageRoute:
      default:
        return MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (_) => const ContentPage(body: HomePage()));
    }
  }
}
