import 'package:flutter/material.dart';

Container backgroundGradient = Container(
  decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.greenAccent, Colors.blueAccent],
          begin: const FractionalOffset(0.5, 0.0),
          end: const FractionalOffset(0.0, 0.5),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
      ),
  ),
);
