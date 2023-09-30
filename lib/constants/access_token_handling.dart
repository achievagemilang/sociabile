import 'package:shared_preferences/shared_preferences.dart';

class AccessTokenHandling {
  // Method to save token in SharedPreferences
  static Future<void> saveTokenToPrefs(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
  }

  // Method to get token from SharedPreferences
  static Future<String?> getTokenFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }
}
