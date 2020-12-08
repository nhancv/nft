import 'package:flutter/material.dart';

/// Remember call super.build(context) in widget
abstract class BaseStateful<T extends StatefulWidget> extends State<T> {
  // Context valid to create providers
  @protected
  void initDependencies(BuildContext context);

  @protected
  void afterFirstBuild(BuildContext context);

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      afterFirstBuild(context);
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    initDependencies(context);
    return null;
  }
}
