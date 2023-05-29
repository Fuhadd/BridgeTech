import 'package:flutter/material.dart';
import 'package:urban_hive_test/Helpers/colors.dart';

ThemeData theme() {
  return ThemeData(
      fontFamily: 'Lato',
      secondaryHeaderColor: Colors.deepPurple,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
        displayMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        displaySmall: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        headlineMedium: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 19,
        ),
        headlineSmall: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        titleLarge: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.yellow)
          .copyWith(secondary: Color(0xfff4a50C))
          .copyWith(background: background));
}
