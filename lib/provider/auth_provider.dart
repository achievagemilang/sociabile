import 'package:flutter/material.dart';
import 'package:sociabile/constants/user_handling.dart';
import 'package:sociabile/models/user.dart';
import 'package:sociabile/services/auth_services.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService authService = AuthService();
  User? _user;

  User? get user => _user;
  void setUser(User? user) async {
    _user = await UserHandling.getUserFromPrefs();

    // print(user);
    if (user != null) {
      _user = user;
      notifyListeners();
    }
  }
}
