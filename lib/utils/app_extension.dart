import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppExtension {}

/// Extension for screen util
extension SizeExtension on num {
  double get W => w.toDouble();

  double get H => h.toDouble();

  /// ignore: non_constant_identifier_names
  double get SP => sp.toDouble();

  /// ignore: non_constant_identifier_names
  double get SSP => ssp.toDouble();
}
