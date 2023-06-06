import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nft/services/app/app_theme.dart';
import 'package:nft/utils/app_extension.dart';

abstract class BaseStateful<T extends ConsumerStatefulWidget> extends ConsumerState<T> {
  late AppTheme appTheme;

  @mustCallSuper
  @protected
  void initDependencies(WidgetRef ref) {
    appTheme = ref.appTheme();
  }

  @protected
  void afterFirstBuild(WidgetRef ref) {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    initDependencies(ref);
  }

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        afterFirstBuild(ref);
      }
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
