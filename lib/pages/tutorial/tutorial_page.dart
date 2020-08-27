import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nft/pages/base/content_page.dart';
import 'package:nft/widgets/route_active_mixin.dart';

class TutorialPage extends ModalRoute<void> {
  TutorialPage({final RouteSettings settings}) : _settings = settings;

  final RouteSettings _settings;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.01);

  @override
  String get barrierLabel => null;

  @override
  RouteSettings get settings => _settings;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // Return new state full widget to use route active mixin
    return TutorialBody();
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    /// You can add your own animations for the overlay content
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(animation),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}

class TutorialBody extends StatefulWidget {
  @override
  _TutorialBodyState createState() => _TutorialBodyState();
}

class _TutorialBodyState extends State<TutorialBody>
    with RouteActiveMixin<TutorialBody> {
  @override
  Widget build(BuildContext context) {
    return ContentPage(
      body: _buildOverlayContent(context),
      customAppColor: Colors.transparent,
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'This is a nice overlay',
              style: TextStyle(color: Colors.black, fontSize: 30.0),
            ),
            RaisedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Dismiss'),
            )
          ],
        ),
      ),
    );
  }
}
