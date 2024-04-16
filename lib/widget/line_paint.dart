import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LinePaint extends CustomPainter{
  List<Offset> points;
  LinePaint({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint=Paint()
        ..color=Colors.yellow
        ..strokeWidth=5.w;
    if(points.isNotEmpty){
      canvas.drawLine(points[0], points.last, paint);
      // canvas.drawLine(Offset(31, 0), Offset(287, 367), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}