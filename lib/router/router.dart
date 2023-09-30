import 'package:flutter/material.dart';
import 'package:sociabile/constants/global_variables.dart';
import 'package:sociabile/page/login_page.dart';
import 'package:sociabile/page/main_page.dart';
import 'package:sociabile/page/register_page.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoginPage.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
    case RegisterPage.routeName:
      return MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      );
    case MainPage.routeName:
      return MaterialPageRoute(
        builder: (context) => MainPage(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          backgroundColor: GlobalVariables.secondaryColor,
          body: Center(
            child: Text(
              "404 Not Found!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
  }
}
