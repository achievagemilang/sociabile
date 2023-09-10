import 'package:flutter/material.dart';

String uri = 'http://10.0.2.2:3001';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color(0xFF5038BC);
  static const backgroundColor = Color(0xFF121212);
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = const Color(0xFF5038BC);
  static const unselectedNavBarColor = Colors.black87;
}