import 'package:flutter/material.dart';
import 'package:nft/my_app.dart';
import 'package:nft/utils/app_log.dart';

mixin RouteActiveMixin<T extends StatefulWidget> on State<T>
    implements RouteAware {
  bool active;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MyApp.routeObserver
        .subscribe(this, ModalRoute.of(context) as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    MyApp.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() => onActive();

  @override
  void didPopNext() => onActive();

  @override
  void didPop() => onInactive();

  @override
  void didPushNext() => onInactive();

  void onActive() {
    active = true;
    logger.d(
        '${runtimeType.toString()} onActive ${ModalRoute.of(context).settings.name}');
  }

  void onInactive() {
    active = false;
    logger.d(
        '${runtimeType.toString()} onInactive ${ModalRoute.of(context).settings.name}');
  }
}
