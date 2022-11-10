import 'dart:math';

import 'package:auto_fix/Constants/cust_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill; // Change this to fill


    /*var path = Path();
    path.moveTo(size.width / 2, Random().nextDouble() * (size.height / 2));
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);*/


    /*Path path = Path();
    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(0, size.height * 0.2, 0, size.height * 0.1);
    path.lineTo(size.width, size.height * 0.1);
    path.lineTo(size.width, size.height * 0.9);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.20, 0, size.height * 0.5);*/

    /*Path path = Path();
    path.moveTo(0.0, size.height);
    path.quadraticBezierTo(size.width / 2, size.height * 0.05, size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, 0.0);*/

    final y = size.height;
    final x = size.width;

    final path = Path();

    path
      ..moveTo(0, y)
      ..lineTo((x / 2), (y / 1.8))..lineTo(x, y);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}