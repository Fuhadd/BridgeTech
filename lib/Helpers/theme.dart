import 'package:flutter/material.dart';
import 'package:urban_hive_test/Helpers/colors.dart';

ThemeData theme() {
  return ThemeData(
      fontFamily: 'Poppins',
      backgroundColor: background,
      primarySwatch: Colors.yellow,
      secondaryHeaderColor: Colors.deepPurple,
      accentColor: Yellow,
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
        headline2: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        headline3: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        headline4: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        headline5: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        headline6: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ));
}
