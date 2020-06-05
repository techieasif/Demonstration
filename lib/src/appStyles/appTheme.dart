import 'package:flutter/material.dart';

enum AppTheme {
  GreenLight,
  GreenDark,
}

final appThemeData = {
  AppTheme.GreenLight: ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.green,
    fontFamily: 'Sans',
    textTheme: Typography.whiteMountainView.copyWith(
        bodyText2: TextStyle(color: Colors.black54),
        bodyText1: TextStyle(color: Colors.black),
        button: TextStyle(color: Colors.black),
    ),
  ),
  AppTheme.GreenDark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green,
    fontFamily: 'Sans',
    textTheme: Typography.whiteMountainView,
  ),
};
