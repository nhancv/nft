
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SampleInfo {
  final String title;
  final List<String> breadCrumb;

  SampleInfo({this.title, this.breadCrumb});

  factory SampleInfo.fromJson(Map<String, dynamic> json) => SampleInfo(
      title: json["title"],
      breadCrumb: List<String>.from(json["breadCrumb"].map((x) => x)));

  Map<String, dynamic> toJson() => {
        "title": title,
        "breadCrumb": List<dynamic>.from(breadCrumb.map((x) => x)),
      };
}

class LocalStorage {
  final String _headerInfoKey = 'header_info';

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Header
  Future<bool> saveHeaderInfo(SampleInfo headerInfo) async {
    final SharedPreferences prefs = await _prefs;
    String headerInfoJson = jsonEncode(headerInfo.toJson());
    return await prefs.setString(_headerInfoKey, headerInfoJson);
  }

  Future<SampleInfo> getHeaderInfo() async {
    final SharedPreferences prefs = await _prefs;
    String headerInfoJson = prefs.getString(_headerInfoKey);
    if (headerInfoJson != null) {
      return SampleInfo.fromJson(jsonDecode(headerInfoJson));
    }
    return null;
  }
}
