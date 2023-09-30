import 'package:flutter/material.dart';

String uri = 'http://10.0.2.2:3000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromARGB(255, 255, 255, 255);
  static const subtitleColor = Color.fromARGB(255, 186, 186, 186);
  static const backgroundColor = Color.fromARGB(255, 3, 3, 3);
  static const Color greyBackgroundCOlor = Color.fromARGB(255, 13, 13, 13);
  static var purpleColor = const Color(0xFF5038BC);
  static const unselectedNavBarColor = Colors.black87;
}
