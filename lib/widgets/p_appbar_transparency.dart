import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nft/services/app/app_theme.dart';
import 'package:nft/utils/app_extension.dart';
import 'package:nft/widgets/p_material.dart';

class PAppBarTransparency extends ConsumerWidget {
  const PAppBarTransparency({this.body, this.child, this.forceStatusIconLight, Key? key}) : super(key: key);

  final Widget? child;
  final Widget? body;
  final bool? forceStatusIconLight;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppTheme theme = ref.appTheme();
    final SystemUiOverlayStyle uiOverlayStyle = forceStatusIconLight == null
        ? (theme.isDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light)
        : forceStatusIconLight == true
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;
    return PMaterial(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: uiOverlayStyle.copyWith(statusBarColor: Colors.transparent),
        child: body ??
            Scaffold(
              backgroundColor: theme.backgroundColor,
              body: child,
            ),
      ),
    );
  }
}
