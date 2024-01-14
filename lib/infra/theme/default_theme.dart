import 'package:flutter/material.dart';

class CustomThemes {
  static final defaultTheme = ThemeData(
    fontFamily: "Roboto",
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: "MarkaziText",
        fontSize: 37,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
