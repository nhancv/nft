import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nft/services/app/app_theme.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/widgets/p_material.dart';

class PAppBarEmpty extends ConsumerWidget {
  const PAppBarEmpty({required this.child, this.actionBtn, Key? key}) : super(key: key);

  final Widget child;
  final Widget? actionBtn;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppTheme theme = ref.appTheme();
    return PMaterial(
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: AppBar(
            elevation: 0,
            systemOverlayStyle: theme.isDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
            backgroundColor: theme.headerBgColor,
          ),
        ),
        body: SafeArea(
          bottom: false,
          child: child,
        ),
        floatingActionButton: actionBtn,
      ),
    );
  }
}
