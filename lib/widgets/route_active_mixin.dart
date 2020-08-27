import 'package:flutter/material.dart';
import 'package:nft/my_app.dart';
import 'package:nft/utils/app_log.dart';

mixin RouteActiveMixin<T extends StatefulWidget> on State<T>
    implements RouteAware {
  bool _subscribed = false;
  bool active = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_subscribed) {
      MyApp.routeObserver
          .subscribe(this, ModalRoute.of(context));
      _subscribed = true;
    }
  }

  @override
  void dispose() {
    if (_subscribed) {
      MyApp.routeObserver.unsubscribe(this);
      _subscribed = false;
    }
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
