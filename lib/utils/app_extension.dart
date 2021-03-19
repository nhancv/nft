import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:nft/generated/l10n.dart';
import 'package:nft/utils/app_route.dart';
import 'package:nft/utils/app_theme.dart';
import 'package:provider/provider.dart';

/// This function's used importing app_extension.dart file quickly.
/// Just type appEx and enter, the IDE will import this file automatically,
/// then you can delete this line, it's up to you.
void appExtension() {}

class AppExtension {}

extension AppRouteExt on BuildContext {
  ThemeData theme() {
    return Theme.of(this);
  }

  AppTheme appTheme() {
    return Provider.of<AppThemeProvider>(this, listen: false).theme;
  }

  AppRoute route() {
    return Provider.of(this, listen: false);
  }

  NavigatorState navigator() {
    return route().navigatorKey.currentState;
  }

  S get strings => S.of(this);
}

/// Extension for screen util
extension SizeExtension on num {
  /// setWidth
  double get W => w.toDouble();

  /// setHeight
  double get H => h.toDouble();

  /// Set sp with default allowFontScalingSelf = false
  /// ignore: non_constant_identifier_names
  double get SP => sp.toDouble();

  /// Set sp with allowFontScalingSelf: true
  /// ignore: non_constant_identifier_names
  double get SSP => ssp.toDouble();

  /// Set sp with allowFontScalingSelf: false
  /// ignore: non_constant_identifier_names
  double get NSP => nsp.toDouble();

  /// % of screen width
  /// ignore: non_constant_identifier_names
  double get SW => sw.toDouble();

  /// % of screen height
  /// ignore: non_constant_identifier_names
  double get SH => sh.toDouble();
}

enum TimeZone { utc, local }

/// Extension for DateTime
extension DateTimeExtension on DateTime {
  String toTime(BuildContext context) =>
      TimeOfDay.fromDateTime(asLocal()).format(context);

  /// Return DateTime with zero millisecond and microsecond
  DateTime resetMillisecond() {
    return DateTime(year, month, day, hour, minute, second);
  }

  DateTime daysBefore(int days) => subtract(Duration(days: days));

  DateTime daysAfter(int days) => add(Duration(days: days));

  DateTime nextDayStart() => onlyDate().daysAfter(1);

  DateTime localTimeToday() => DateTime.now().let((DateTime now) => DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
      second,
      millisecond,
      microsecond));

  DateTime onlyDate() =>
      isUtc ? DateTime.utc(year, month, day) : DateTime(year, month, day);

  DateTime onlyMonth() =>
      isUtc ? DateTime.utc(year, month) : DateTime(year, month);

  DateTime onlyTime([int _hour, int _minute]) =>
      DateTime.utc(1970, 1, 1, _hour ?? hour, _minute ?? minute, 0, 0, 0);

  DateTime atTime(int _hour, int _minute, [int _second]) =>
      DateTime(year, month, day, _hour, _minute, _second ?? 0, 0, 0);

  DateTime utcTimeFirstDaySinceEpoch() =>
      DateTime.utc(1970, 1, 1, hour, minute, second, millisecond, microsecond);

  // Convert local time as current utc
  // DateTime.now() = 2021-01-25 18:49:03.049422
  // DateTime.asUtc() = 2021-01-25 18:49:03.049422
  // DateTime.toUtc() = 2021-01-25 11:49:03.056208Z
  DateTime asUtc() => isUtc
      ? this
      : DateTime.utc(
          year, month, day, hour, minute, second, millisecond, microsecond);

  DateTime asLocal() => !isUtc
      ? this
      : DateTime(
          year, month, day, hour, minute, second, millisecond, microsecond);

  /// 2020-04-03T11:57:00
  String toDateTimeString() {
    return DateFormat('yyyy-MM-ddThh:mm:ss').format(this);
  }

  /// 11:00 AM
  String toHmaa() {
    return DateFormat('hh:mm aaaa').format(this);
  }
}

/// Extension for DateTime from String
extension DateTimeStringExtendsion on String {
  /// Check Null
  bool get isNull => this == null;

  /// Check Null or Empty
  bool get isNullOrEmpty => isNull || isEmpty;

  /// Convert from UTC to local DateTime by pattern
  DateTime toDateTime({String pattern = 'yyyy-MM-dd hh:mm:ss'}) {
    return isNullOrEmpty
        ? null
        : DateFormat(pattern).parse(this, true).toLocal();
  }

  String safe([String supplier()]) =>
      this ?? (supplier == null ? '' : supplier());

  String zeroPrefix(int count) {
    if (length >= count) {
      return this;
    } else {
      String builder = '';
      for (int i = 0; i < count - length; i++) {
        builder += '0';
      }
      builder += this;
      return builder;
    }
  }

  int parseInt() => int.tryParse(this);

  double parseDouble() => double.tryParse(this);

  String truncate(int limit) {
    return length > limit
        ? '${substring(0, min(length, limit)).trim()}...'
        : this;
  }
}

/// Extension for duration
extension DurationExtension on Duration {
  Duration safe([Duration supplier()]) =>
      this ?? (supplier == null ? Duration.zero : supplier());

  String format() {
    return toString().split('.').first.padLeft(8, '0');
  }

  /// Add zero padding
  String _twoDigits(int n) {
    if (n >= 10) {
      return '$n';
    }
    return '0${max(n, 0)}';
  }

  /// hours:minutes:seconds
  String toHms() {
    final String twoDigitHours = _twoDigits(inHours.remainder(24) as int);
    final String twoDigitMinutes = _twoDigits(inMinutes.remainder(60) as int);
    final String twoDigitSeconds = _twoDigits(inSeconds.remainder(60) as int);
    return '$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds';
  }

  /// minutes:seconds
  String toMs() {
    final String twoDigitMinutes = _twoDigits(inMinutes.remainder(60) as int);
    final String twoDigitSeconds = _twoDigits(inSeconds.remainder(60) as int);
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}

/// Extension for int
extension DateExtensions on int {
  DateTime localDateTime() =>
      DateTime.fromMillisecondsSinceEpoch(this, isUtc: false);

  DateTime utcDateTime() =>
      DateTime.fromMillisecondsSinceEpoch(this, isUtc: true);

  DateTime asDateTime({TimeZone from = TimeZone.utc}) {
    switch (from) {
      case TimeZone.local:
        return localDateTime();
      case TimeZone.utc:
      default:
        return utcDateTime();
    }
  }

  DateTime asLocal({TimeZone from = TimeZone.utc}) =>
      asDateTime(from: from).asLocal();

  String toTime(BuildContext context, {TimeZone from = TimeZone.utc}) =>
      asDateTime(from: from).toTime(context);

  int localTimeToday({TimeZone from = TimeZone.utc}) =>
      asDateTime(from: from).localTimeToday().millisecondsSinceEpoch;

  int onlyDate({TimeZone from = TimeZone.utc}) =>
      asDateTime(from: from).onlyDate().millisecondsSinceEpoch;

  int onlyTime({TimeZone from = TimeZone.utc}) =>
      asDateTime(from: from).utcTimeFirstDaySinceEpoch().millisecondsSinceEpoch;

  int utcTimeFirstDaySinceEpoch({TimeZone from = TimeZone.utc}) =>
      asDateTime(from: from).utcTimeFirstDaySinceEpoch().millisecondsSinceEpoch;

  Duration asDuration() => Duration(milliseconds: this);
}

/// Extension for num
extension NumExtensions<T extends num> on T {
  T safe([T supplier()]) => this ?? (supplier == null ? 0 as T : supplier());

  T plus(T value) {
    return this + value as T;
  }
}

/// Extension for bool
extension BoolExtensions on bool {
  bool safe([bool supplier]) => this ?? (supplier ?? false);
}

/// Extension for T
extension AnyExtensions<T> on T {
  /// Check Null
  bool get isNull => this == null;

  T safe(T supplier()) => this ?? supplier();
}

/// Extension for Object
extension Lambdas<T> on T {
  T also(void fun(T it)) {
    fun(this);
    return this;
  }

  R let<R>(R fun(T it)) => fun(this);

  T takeIf(bool test(T it)) => test(this) ? this : null;
}

/// Extension for Comparable on Iterable
extension ComparableIterableExtensions<E extends Comparable<E>> on Iterable<E> {
  List<E> sorted() => toList()..sort();

  E min() {
    final Iterator<E> iterator = this.iterator;
    if (!iterator.moveNext()) {
      return null;
    }
    E min = iterator.current;
    while (iterator.moveNext()) {
      final E e = iterator.current;
      if (min > e) {
        min = e;
      }
    }
    return min;
  }

  E max() {
    final Iterator<E> iterator = this.iterator;
    if (!iterator.moveNext()) {
      return null;
    }
    E max = iterator.current;
    while (iterator.moveNext()) {
      final E e = iterator.current;
      if (max < e) {
        max = e;
      }
    }
    return max;
  }
}

/// Extension for Set
extension SetExtensions<E> on Set<E> {
  Set<E> filterNotNull() => where((E it) => it != null).toSet();
}

/// Extension for Map
extension MapExtensions<K, V> on Map<K, V> {
  V get(K key) => this[key];

  V getOrDefault(K key, V value) => containsKey(key) ? this[key] : value;
}

/// Extension for Iterable of Iterable
extension IterableIterableExtensions<E> on Iterable<Iterable<E>> {
  List<E> flatten() => expand((Iterable<E> it) => it).toList(growable: false);
}

/// Extension for Comparable
extension ComparableExtensions<T> on Comparable<T> {
  bool operator >(T value) => compareTo(value) == 1;

  bool operator >=(T value) =>
      compareTo(value).let((int it) => it == 1 || it == 0);

  bool operator <(T value) => compareTo(value) == -1;

  bool operator <=(T value) =>
      compareTo(value).let((int it) => it == -1 || it == 0);
}

/// Extension for Iterable
extension IterableExtensions<E> on Iterable<E> {
  /// Returns the first element.
  ///
  /// Returns `null` if `this` is empty.
  /// Otherwise returns the first element in the iteration order
  E get firstOrNull =>
      iterator.let((Iterator<E> it) => !it.moveNext() ? null : it.current);

  E get lastOrNull {
    final Iterator<E> it = iterator;
    if (!it.moveNext()) {
      return null;
    }
    E result;
    do {
      result = it.current;
    } while (it.moveNext());
    return result;
  }

  /// Returns the first element that satisfies the given predicate [test].
  ///
  /// Iterates through elements and returns the first to satisfy [test].
  ///
  /// If no element satisfies [test], the result returns `null`
  E find(bool test(E element)) {
    for (final E element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }

  List<E> filter(bool test(E element)) => where(test).toList(growable: false);

  List<E> filterNotNull() =>
      where((E it) => it != null).toList(growable: false);

  bool get isNullOrEmpty => this == null || isEmpty;

  Iterable<E> safe() => this ?? <E>[];

  List<E> safeList() => this == null ? <E>[] : toList();

  E minBy<R extends Comparable<R>>(R selector(E element)) {
    final Iterator<E> iterator = this.iterator;
    if (!iterator.moveNext()) {
      return null;
    }
    E minElem = iterator.current;
    if (!iterator.moveNext()) {
      return minElem;
    }
    R minValue = selector(minElem);
    do {
      final E e = iterator.current;
      final R v = selector(e);
      if (minValue > v) {
        minElem = e;
        minValue = v;
      }
    } while (iterator.moveNext());
    return minElem;
  }

  E minWith(int compare(E a, E b)) {
    final Iterator<E> iterator = this.iterator;
    if (!iterator.moveNext()) {
      return null;
    }
    E min = iterator.current;
    while (iterator.moveNext()) {
      final E e = iterator.current;
      if (compare(min, e) > 0) {
        min = e;
      }
    }
    return min;
  }

  /// Returns the first element yielding the largest value of the given function or `null` if there are no elements.
  ///
  /// @sample samples.collections.Collections.Aggregates.maxBy
  E maxBy<R extends Comparable<R>>(R selector(E element)) {
    final Iterator<E> iterator = this.iterator;
    if (!iterator.moveNext()) {
      return null;
    }
    E maxElem = iterator.current;
    if (!iterator.moveNext()) {
      return maxElem;
    }
    R maxValue = selector(maxElem);
    do {
      final E e = iterator.current;
      final R v = selector(e);
      if (maxValue < v) {
        maxElem = e;
        maxValue = v;
      }
    } while (iterator.moveNext());
    return maxElem;
  }

  /// Returns the first element having the largest value according to the provided [comparator] or `null` if there are no elements.
  E maxWith(int compare(E a, E b)) {
    final Iterator<E> iterator = this.iterator;
    if (!iterator.moveNext()) {
      return null;
    }
    E max = iterator.current;
    while (iterator.moveNext()) {
      final E e = iterator.current;
      if (compare(max, e) < 0) {
        max = e;
      }
    }
    return max;
  }

  int sumBy(int fun(E element)) {
    int sum = 0;
    forEach((E it) => sum += fun(it));
    return sum;
  }

  String joinToString(
      {String separator = '',
      String prefix = '',
      String postfix = '',
      String transform(E element)}) {
    String result = prefix;

    bool first = true;
    forEach((E it) {
      if (!first) {
        result += separator;
      } else {
        first = false;
      }
      result += transform == null ? '$it' : transform(it);
    });

    result += postfix;
    return result;
  }

  Future<List<R>> asyncMap<R>(FutureOr<R> fun(E element)) async {
    final List<R> items = <R>[];
    for (final E it in this) {
      items.add(await fun(it));
    }
    return items;
  }
}

/// Extension for List
extension ListExtensions<E> on List<E> {
  E get(int index) => this[index];

  void set(int index, E element) => this[index] = element;

  E getOrNull(int index) => index < 0 || index >= length ? null : this[index];

  void forEachIndexed(void f(int index, E element)) {
    for (int i = 0; i < length; i++) {
      f(i, this[i]);
    }
  }

  List<R> mapIndexed<R>(R transform(int index, E value)) =>
      mapIndexedTo<R, List<R>>(<R>[], transform);

  C mapIndexedTo<R, C extends List<R>>(
      C destination, R transform(int index, E value)) {
    forEachIndexed(
        (int index, E element) => destination.add(transform(index, element)));
    return destination;
  }

  int get lastIndex => length - 1;

  List<E> reversedList() => reversed.toList(growable: false);

  List<E> shuffled([Random random]) => toList(growable: false)..shuffle(random);

  List<E> sorted(int compare(E a, E b)) =>
      toList(growable: false)..sort(compare);

  List<E> sortedBy<T extends Comparable<T>>(T selector(E value)) =>
      toList(growable: false)
        ..sort((E a, E b) => selector(a).compareTo(selector(b)));

  List<E> safe() => this ?? <E>[];

  void moveAt(int oldIndex, int index) {
    final E item = this[oldIndex];
    removeAt(oldIndex);
    insert(index, item);
  }

  void move(int index, E item) {
    remove(item);
    insert(index, item);
  }

  int indexOfItem(E element, Iterable<int> exclude) {
    for (int i = 0; i < length; i++) {
      if (!exclude.contains(i) && this[i] == element) {
        return i;
      }
    }
    return -1;
  }

  int indexOfWhere(bool test(int index, E element)) {
    for (int i = 0; i < length; i++) {
      if (test(i, this[i])) {
        return i;
      }
    }
    return -1;
  }

  static List<E> insertBetween<E>(E delimiter, List<E> tokens) {
    final List<E> sb = <E>[];
    bool firstTime = true;
    for (final E token in tokens) {
      if (firstTime) {
        firstTime = false;
      } else {
        sb.add(delimiter);
      }
      sb.add(token);
    }
    return sb;
  }
}
