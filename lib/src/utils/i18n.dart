import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class I18n {
  Map<String, dynamic> _en = {};
  Map<String, dynamic> _ar = {};
  static final I18n _i = I18n._();
  I18n._();
  factory I18n() => _i;

  Future<void> load() async {
    _en = jsonDecode(await rootBundle.loadString('assets/lang/en.json'));
    _ar = jsonDecode(await rootBundle.loadString('assets/lang/ar.json'));
  }

  String t(String key, {Map<String, String>? vars, String lang='en'}) {
    final map = lang == 'ar' ? _ar : _en;
    var raw = map[key] ?? key;
    vars?.forEach((k, v) { raw = raw.toString().replaceAll('{$k}', v); });
    return raw.toString();
  }
}
