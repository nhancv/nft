import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SampleInfo {
  SampleInfo({this.title, this.breadCrumb});

  factory SampleInfo.fromJson(Map<String, dynamic> json) => SampleInfo(
      title: json['title'] as String,
      breadCrumb: List<String>.from(
          (json['breadCrumb'] as Iterable<String>).map((String x) => x)));

  final String title;
  final List<String> breadCrumb;

  // ignore: always_specify_types
  Map<String, dynamic> toJson() => {
        'title': title,
        'breadCrumb': List<dynamic>.from(breadCrumb.map((String x) => x)),
      };
}

class LocalStorage {
  final String _headerInfoKey = 'header_info';

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Header
  Future<bool> saveHeaderInfo(SampleInfo headerInfo) async {
    final SharedPreferences prefs = await _prefs;
    final String headerInfoJson = jsonEncode(headerInfo.toJson());
    return prefs.setString(_headerInfoKey, headerInfoJson);
  }

  Future<SampleInfo> getHeaderInfo() async {
    final SharedPreferences prefs = await _prefs;
    final String headerInfoJson = prefs.getString(_headerInfoKey);
    if (headerInfoJson != null) {
      return SampleInfo.fromJson(
          jsonDecode(headerInfoJson) as Map<String, dynamic>);
    }
    return null;
  }
}
