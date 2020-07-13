import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:nft/utils/app_theme.dart';
import 'package:nft/widgets/appbar_padding.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({@required this.body, Key key, this.customAppColor})
      : super(key: key);

  final Widget body;
  final Color customAppColor;

  @override
  Widget build(BuildContext context) {
    // Set the fit size (fill in the screen size of the device in the design)
    // https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
    // Size of iPhone 8: 375 × 667 (points) - 750 × 1334 (pixels) (2x)
    ScreenUtil.init(context, width: 375, height: 667);
    WidgetsBinding.instance.addPostFrameCallback((_) => onAfterBuild(context));

    final AppTheme theme = context.theme();
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: const Size(0, 0),
          child: AppBar(
              elevation: 0,
              brightness: theme.isDark ? Brightness.dark : Brightness.light,
              backgroundColor: theme.headerBgColor),
        ),
        body: AppBarPadding(
          backgroundColor: customAppColor ?? theme.backgroundColor,
          child: SafeArea(
            bottom: false,
            child: body,
          ),
        ),
      ),
    );
  }

  // After widget initialized.
  void onAfterBuild(BuildContext context) {}
}