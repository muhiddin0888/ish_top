import 'package:flutter/material.dart';

class HalfCircleOnTopPaint extends CustomPainter{
  // Thanks Abdulbosit bro
  @override
  void paint(Canvas canvas, Size size) {

    Paint paint0 = Paint()
      ..color = const Color(0xFFCFD5DE)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path0 = Path();
    path0.moveTo(0,size.height*0.0715000);
    path0.quadraticBezierTo(size.width*-0.0027174,size.height*0.0210000,size.width*-0.0036232,size.height*0.0041667);
    path0.quadraticBezierTo(size.width*0.7490942,size.height*0.0011667,size.width,size.height*0.0001667);
    path0.quadraticBezierTo(size.width*0.9996014,size.height*0.0185250,size.width*0.9984058,size.height*0.0736000);
    path0.quadraticBezierTo(size.width*0.5084058,size.height*0.3045667,0,size.height*0.0715000);
    path0.close();

    canvas.drawPath(path0, paint0);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
