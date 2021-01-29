import 'package:flutter/material.dart';
import 'package:nft/services/app/dynamic_size.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/utils/app_theme.dart';

/// Remember call super.build(context) in widget
/// ignore: must_be_immutable
abstract class BaseStateless extends StatelessWidget with DynamicSize {
  BaseStateless({Key key}) : super(key: key);

  AppTheme appTheme;

  /// Context valid to create providers
  @mustCallSuper
  @protected
  void initDependencies(BuildContext context) {
    appTheme = context.appTheme();
  }

  @protected
  void afterFirstBuild(BuildContext context) {}

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
