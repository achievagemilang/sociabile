import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sociabile/constants/access_token_handling.dart';
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/constants/http_error_handling.dart';
import 'package:sociabile/constants/user_handling.dart';
import 'package:sociabile/constants/utility.dart';
import 'package:sociabile/page/login_page.dart';
import 'package:sociabile/page/main_page.dart';
import 'package:sociabile/provider/auth_provider.dart';

import '../models/user.dart';

class AuthService {
  static final String authUrl = "$uri/api/auth";

  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$authUrl/register'),
        body: {
          "firstName": firstName,
          "password": password,
          "email": email,
          "lastName": lastName,
        },
      );

      print(res.body);

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {
          showSnackbar(context, "Successfully registered!", true);
          Navigator.pushReplacementNamed(context, LoginPage.routeName);
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<String?> logInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$authUrl/login'),
        body: {
          "password": password,
          "email": email,
        },
      );

      print(res.body);

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {},
      );

      var jsonResponse = jsonDecode(res.body);
      print(jsonResponse["data"]["data"]);
      if (jsonResponse['status'] == true) {
        String token = jsonResponse['data']['token'];
        await AccessTokenHandling.saveTokenToPrefs(
            token); // Save token to SharedPreferences

        User user = User.fromJson(jsonResponse["data"]["data"]);
        // print(user.firstName);

        await UserHandling.saveUserToPrefs(user);
        User? prefUser = await UserHandling.getUserFromPrefs();
        print(prefUser!.firstName);

        context.read<AuthProvider>().setUser(prefUser);

        showSnackbar(context, "Successfully login!", true);
        Navigator.pushReplacementNamed(context, MainPage.routeName);
        return token;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return null;
  }

  Future<User?> getProfileUser({
    required BuildContext context,
  }) async {
    try {
      String? token = await AccessTokenHandling
          .getTokenFromPrefs(); // Get token from SharedPreferences

      if (token == null) {
        throw Exception("Token not found");
      }

      http.Response res = await http.get(
        Uri.parse('$authUrl/profile'),
        headers: <String, String>{
          'Authorization': "Bearer $token",
        },
      );

      print(res.body);

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {
          print(res.body);
          String resUser = jsonDecode(res.body)["data"].toString();
          print(resUser);
          showSnackbar(context, "Successfully Fetched!", true);
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    return null;
  }
}
