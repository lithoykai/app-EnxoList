import 'package:enxolist/infra/theme/colors_theme.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: ColorsTheme.background,
  canvasColor: const Color.fromARGB(144, 240, 236, 236),
  fontFamily: "Roboto",
  cardColor: ColorsTheme.greyTransparent,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    surface: ColorsDark.listViewColor, //profile listview
    secondary: Colors.black, //text form
    error: Colors.red,
    onSurface: ColorsTheme.backgroundForm, //background form
    onError: Colors.red,
    onSecondary: ColorsTheme.textColor, // textsWhite
    primary: ColorsTheme.primaryColor,
    onPrimary: ColorsTheme.primaryColorLight,
    outline: ColorsTheme.backgroundForm,
  ),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(color: Colors.black87), //ProductCard Title color
    headlineMedium: TextStyle(color: Colors.black), //ProductCard Title color
    headlineLarge: TextStyle(
        color: ColorsTheme.primaryColor,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(
      color: Colors.black,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300,
    ),
    bodyMedium: TextStyle(
      color: ColorsTheme.textColor,
      fontFamily: 'Roboto',
      fontSize: 18,
      fontWeight: FontWeight.w300,
    ),
    displayLarge: TextStyle(
      fontSize: 40,
      fontFamily: "Roboto",
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    displayMedium: TextStyle(
      fontSize: 40,
      fontFamily: "MarkaziText",
      color: Colors.black,
    ),
    displaySmall: TextStyle(
      fontSize: 20,
      fontFamily: "MarkaziText",
      color: ColorsTheme.textColor,
    ),
  ),
  useMaterial3: true,
);
ThemeData darkTheme = ThemeData(
  cardColor: ColorsDark.listViewColor,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: ColorsDark.background,
  canvasColor: const Color.fromARGB(144, 240, 236, 236), //background
  fontFamily: "Roboto",
  colorScheme: const ColorScheme(
    surface: ColorsDark.listViewColor, //profile listview
    secondary: Colors.black, //text form
    error: Colors.red,
    onError: Colors.red,
    onSecondary: Colors.white, // textsWhite
    onSurface: ColorsDark.backgroundForm,
    brightness: Brightness.dark,
    primary: ColorsTheme.primaryColor,
    onPrimary: ColorsTheme.primaryColor,
    outline: ColorsTheme.backgroundForm,
  ),
  unselectedWidgetColor: ColorsDark.secundary,
  textTheme: const TextTheme(
    headlineSmall: TextStyle(color: Colors.black87),
    headlineMedium: TextStyle(color: ColorsDark.secundary),
    headlineLarge: TextStyle(
        color: ColorsTheme.primaryColor,
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(
      color: ColorsDark.secundary,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300,
    ),
    displayLarge: TextStyle(
      fontSize: 40,
      fontFamily: "Roboto",
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      color: ColorsDark.secundary,
    ),
    displayMedium: TextStyle(
      fontSize: 40,
      fontFamily: "MarkaziText",
      color: ColorsDark.secundary,
    ),
    displaySmall: TextStyle(
      fontSize: 20,
      fontFamily: "MarkaziText",
      color: ColorsDark.secundary,
    ),
  ),
  useMaterial3: true,
);

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
