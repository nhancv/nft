import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AppExtension {}

/// Extension for screen util
extension SizeExtension on num {
  // setWidth
  double get W => w.toDouble();

  // setHeight
  double get H => h.toDouble();

  // Set sp with default allowFontScalingSelf = false
  /// ignore: non_constant_identifier_names
  double get SP => sp.toDouble();

  // Set sp with allowFontScalingSelf: true
  /// ignore: non_constant_identifier_names
  double get SSP => ssp.toDouble();

  // Set sp with allowFontScalingSelf: false
  /// ignore: non_constant_identifier_names
  double get NSP => nsp.toDouble();

  // % of screen width
  // ignore: non_constant_identifier_names
  double get SW => sw.toDouble();

  // % of screen height
  // ignore: non_constant_identifier_names
  double get SH => sh.toDouble();

}

/// Extension for DateTime
extension DateTimeExtension on DateTime {
  // Convert DateTime to String
  // 2020-04-03T11:57:00
  String toDateTimeString() {
    return DateFormat('yyyy-MM-ddThh:mm:ss').format(this);
  }
}

/// Extension for DateTime from String
extension DateTimeStringExtendsion on String {
  // Check Null
  bool get isNull => this == null;

  // Check Null or Empty
  bool get isNullOrEmpty => isNull || isEmpty;

  // Convert to DateTime by pattern
  DateTime toDateTime(String pattern) {
    return isNullOrEmpty ? null : DateFormat(pattern).parse(this);
  }

}
