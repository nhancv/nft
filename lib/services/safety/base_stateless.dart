import 'package:flutter/material.dart';
import 'package:nft/services/app/dynamic_size.dart';

/// Remember call super.build(context) in widget
abstract class BaseStateless extends StatelessWidget with DynamicSize {

  const BaseStateless({Key key}): super(key: key);

  // Context valid to create providers
  @protected
  void initDependencies(BuildContext context);

  @protected
  void afterFirstBuild(BuildContext context);

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    initDependencies(context);
    initDynamicSize(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      afterFirstBuild(context);
    });
    return null;
  }
}
