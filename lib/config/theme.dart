import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: const Color(0xffECEFF4),
    fontFamily: "Rubik",
    textTheme: textTheme(),
  );
}

TextTheme textTheme() {
  return const TextTheme(
    headline1: TextStyle(
      color: Color(0xff2E3440),
      fontWeight: FontWeight.bold,
      fontSize: 36,
    ),
    headline2: TextStyle(
      color:Color(0xff2E3440),
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    headline3: TextStyle(
      color: Color(0xff2E3440),
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    headline4: TextStyle(
      color: Color(0xff2E3440),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    headline5: TextStyle(
      color: Color(0xff2E3440),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    headline6: TextStyle(
      color: Color(0xff2E3440),
      fontWeight: FontWeight.normal,
      fontSize: 14,
    ),
    bodyText1: TextStyle(
      color: Color(0xff2E3440),
      fontWeight: FontWeight.normal,
      height: 1.75,
      fontSize: 12,
    ),
    bodyText2: TextStyle(
      color: Color(0xff2E3440),
      fontWeight: FontWeight.normal,
      fontSize: 10,
    ),
    subtitle1: TextStyle(
      color: Color(0xff2E3440),
      fontWeight: FontWeight.normal,
      fontSize: 16,
    ),
  );
}