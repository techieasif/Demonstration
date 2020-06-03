import 'package:flutter/material.dart';
BoxDecoration customDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    boxShadow: [
      BoxShadow(
        color: Color(0xFF656565).withOpacity(0.15),
        blurRadius: 2.0,
        spreadRadius: 1.0,
      )
    ]);

TextStyle titleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.black54
);