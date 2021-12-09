import 'package:lumas/general/configs.dart';
import 'package:flutter/material.dart';

class AppTheme {
  ThemeData generateTheme() {
    return ThemeData(
        fontFamily: 'Inter',
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        splashColor: Colors.white,
        textTheme: TextTheme(
          bodyText1: TextStyle(),
          bodyText2: TextStyle(),
        ).apply(
          bodyColor: AppColor.pinkPrimary,
          displayColor: AppColor.pinkPrimary,
        ),
        iconTheme: IconThemeData(color: AppColor.pinkPrimary),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColor.pinkPrimary,
        ),
        accentColor: AppColor.pinkPrimary,
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
            color: AppColor.pinkPrimary,
          ),
        ),
        appBarTheme: AppBarTheme(backgroundColor: AppColor.pinkPrimary));
  }

  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();
}
