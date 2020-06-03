import 'dart:typed_data';

import 'package:flutter/material.dart';

class Bubbles extends StatelessWidget {
  final Color bigCircleColor;
  final Color smallCircleColor;
  final double height;

  const Bubbles({Key key, this.bigCircleColor, this.smallCircleColor, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ShapesPainter(smallCircleColor: smallCircleColor, bigCircleColor: bigCircleColor),
      child: Container(
        height: height,
      ),
    );
  }
}

class ShapesPainter extends CustomPainter {
  final Color bigCircleColor;
  final Color smallCircleColor;

  ShapesPainter({this.bigCircleColor, this.smallCircleColor});

  @override
  void paint(Canvas canvas, Size size) {
    final big = Paint();
    final small = Paint();

    big.color = bigCircleColor ?? Colors.grey.shade900;
    var bigSize = Offset(size.width / 8, size.height / 4.5);
    canvas.drawCircle(bigSize, 110.0, big);

    small.color = smallCircleColor ?? Colors.lightBlue;
    var smallSize = Offset(size.width / 3.5, size.height / 1.8);
    canvas.drawCircle(smallSize, 80.0, small);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}