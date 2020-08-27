import 'package:flutter/material.dart';
import 'package:nft/pages/base/content_page.dart';
import 'package:nft/pages/counter/counter_page.dart';
import 'package:nft/pages/home/home_page.dart';
import 'package:nft/pages/tutorial/tutorial_page.dart';
import 'package:nft/utils/app_constant.dart';

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstant.rootPageRoute:
        return MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (_) => const ContentPage(body: HomePage()));
      case AppConstant.tutorialPageRoute:
        return TutorialPage();
      case AppConstant.counterPageRoute:
        return MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (_) => ContentPage(
                body: CounterPage(argument: settings.arguments as String)));
      default:
        return MaterialPageRoute<dynamic>(
            settings: settings,
            builder: (_) => const ContentPage(body: HomePage()));
    }
  }
}
