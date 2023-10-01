import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sociabile/models/user.dart';

class UserHandling {
  static Future<void> saveUserToPrefs(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(user.toJson()));
  }

  static Future<User?> getUserFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userJson = prefs.getString('user');
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }
}
