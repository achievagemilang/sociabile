// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/constants/http_error_handling.dart';
import 'package:sociabile/constants/utility.dart';
import 'package:sociabile/page/login_page.dart';
import 'package:sociabile/page/main_page.dart';
import 'package:sociabile/provider/auth_provider.dart';

class AuthService {
  static final String authUrl = "$uri/api/auth";

  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phone,
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
      // print(lastName);
      // print(authUrl);
      // print(res.statusCode);
      // print(res.contentLength);
      print(res.body);
      // print(res.isRedirect);

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // await prefs.setString('resendEmailToken',
          //     jsonDecode(res.body)["data"]["resendEmailToken"]);

          showSnackbar(context, "Successfully registered!", true);
          Navigator.pushReplacementNamed(context, LoginPage.routeName);
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void logInUser({
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
      // print(lastName);
      // print(authUrl);
      // print(res.statusCode);
      // print(res.contentLength);
      // print(res.body);
      // print(res.isRedirect);
      print(res.body);

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // await prefs.setString(
          //     'accessToken', jsonDecode(res.body)["data"]["accessToken"]);
          // await prefs.setString(
          //     'refreshToken', jsonDecode(res.body)["data"]["refreshToken"]);
          // await prefs.setString(
          //   'resendEmailToken',
          //   jsonDecode(res.body)["data"]["resendEmailToken"],
          // );

          // String? accessToken = prefs.getString('accessToken');
          // String? refreshToken = prefs.getString('refreshToken');
          // String? resendEmailToken = prefs.getString('resendEmailToken');

          // print(accessToken);
          // print(refreshToken);
          // print(resendEmailToken);

          // print(jsonDecode(res.body)["data"].toString());
          // print("notostring: ${jsonDecode(res.body)["data"]}");

          showSnackbar(context, "Successfully login!", true);
          Navigator.pushReplacementNamed(context, MainPage.routeName);
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void getProfileUser({
    required BuildContext context,
  }) async {
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? accessToken = prefs.getString('accessToken');
      // String? refreshToken = prefs.getString('refreshToken');
      // String? resendEmailToken = prefs.getString('resendEmailToken');

      http.Response res = await http.get(
        Uri.parse('$authUrl/profile'),
        headers: <String, String>{
          // 'Authorization': "Bearer $accessToken",
        },
      );
      // print(lastName);
      // print(authUrl);
      // print(res.statusCode);
      // print(res.contentLength);
      // print(res.body);
      // print(res.isRedirect);
      print(res.body);

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () async {
          print(res.body);
          String resUser = jsonDecode(res.body)["data"].toString();
          print(resUser);
          // Provider.of<AuthProvider>(context, listen: false).setUser(resUser);

          showSnackbar(context, "Successfully Fetched!", true);
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
