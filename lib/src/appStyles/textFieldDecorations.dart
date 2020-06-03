import 'package:flutter/material.dart';

InputDecoration textFieldDecoration({@required hintText}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        width: 0,
        style: BorderStyle.none,
      ),
    ),
    fillColor: Colors.grey.shade100,
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    filled: true,
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 14),
  );
}