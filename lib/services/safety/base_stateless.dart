import 'package:flutter/material.dart';

/// Remember call super.build(context) in widget
abstract class BaseStateless extends StatelessWidget {
  // Context valid to create providers
  @protected
  void initDependencies(BuildContext context);

  @protected
  void afterFirstBuild(BuildContext context);

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    initDependencies(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      afterFirstBuild(context);
    });
    return null;
  }
}
