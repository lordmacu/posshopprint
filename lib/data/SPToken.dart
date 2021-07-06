import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SPToken {
  static Future<SharedPreferences> get _sp => SharedPreferences.getInstance();
  static final String tokenKey = 'token';

  static Future<String> get() async =>
      (await _sp).getString(tokenKey) ?? '';

  static Future set(String token) async =>
      (await _sp).setString(tokenKey, token);
}
