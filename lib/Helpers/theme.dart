import 'package:flutter/material.dart';
import 'package:urban_hive_test/Helpers/colors.dart';

ThemeData theme() {
  return ThemeData(
      fontFamily: 'Lato',
      backgroundColor: background,
      primarySwatch: Colors.yellow,
      secondaryHeaderColor: Colors.deepPurple,
      accentColor: Color(0xfff4a50C),
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
          fontSize: 19,
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
