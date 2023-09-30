import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:sociabile/models/user.dart';
import 'package:sociabile/services/auth_services.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService authService = AuthService();
  User _user = User(
    id: 0,
    firstName: '',
    lastName: '',
    email: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  User get user => _user;
  void setUser(String user) {
    // print(user);
    // _user = User.fromJson(user);
    // notifyListeners();
  }
}
