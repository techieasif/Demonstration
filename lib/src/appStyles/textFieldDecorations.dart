import 'package:flutter/material.dart';

InputDecoration textFieldDecoration({@required hintText, BuildContext context}) {
  bool isDark = Theme.of(context).brightness == Brightness.dark;
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    fillColor: isDark ? null : Colors.grey.shade100,
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    filled: true,
    hintText: hintText,



//    hintStyle: isDark
  );
}