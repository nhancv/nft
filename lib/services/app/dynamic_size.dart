import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/screenutil.dart';

/// Usage:
/// class _MyAppState extends State<MyApp> with DynamicSize {
///   @override
///   Widget build(BuildContext context) {
///     initDynamicSize(context);
///     return Container();
///   }
/// }
mixin DynamicSize {
  /// Init dynamic size
  void initDynamicSize(BuildContext context) {
    /// Set the fit size (fill in the screen size of the device in the design)
    /// https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions
    /// Size of iPhone 8: 375 × 667 (points) - 750 × 1334 (pixels) (2x)
    ScreenUtil.init(context, designSize: const Size(375, 667));
  }
}
