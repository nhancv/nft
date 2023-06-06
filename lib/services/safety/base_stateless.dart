import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nft/services/app/app_theme.dart';
import 'package:nft/utils/app_extension.dart';

/// ignore: must_be_immutable
abstract class BaseStateless extends ConsumerWidget {
  BaseStateless({Key? key}) : super(key: key);

  late AppTheme appTheme;

  @mustCallSuper
  @protected
  void initDependencies(WidgetRef ref) {
    appTheme = ref.appTheme();
  }

  @protected
  void afterFirstBuild(WidgetRef ref) {}

  @mustCallSuper
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    initDependencies(ref);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      afterFirstBuild(ref);
    });
    return Container();
  }
}
