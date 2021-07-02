import 'package:shared_preferences/shared_preferences.dart';

class AppToken {
  Future<void> set(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", token);
  }

  Future<String> get() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString("token");
    return (data == null) ? "" : data;
  }
}
