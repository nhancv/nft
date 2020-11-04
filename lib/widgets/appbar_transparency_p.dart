import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nft/utils/app_theme.dart';
import 'package:nft/widgets/material_p.dart';

class AppBarTransparencyP extends StatelessWidget {
  const AppBarTransparencyP({@required this.child, Key key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.theme();
    final SystemUiOverlayStyle uiOverlayStyle =
        theme.isDark ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light;
    return MaterialP(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: uiOverlayStyle.copyWith(statusBarColor: Colors.transparent),
        child: Scaffold(
          backgroundColor: theme.backgroundColor ?? Colors.transparent,
          body: child,
        ),
      ),
    );
  }
}
