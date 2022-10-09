// Thanks Abdulbosit bro
import 'package:flutter/material.dart';



class HalfCirleOnTopPaint extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    

  Paint paint0 = Paint()
      ..color = const Color(0xFFCFD5DE)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
     
         
    Path path0 = Path();
    path0.moveTo(0,0);
    path0.quadraticBezierTo(0,size.height*0.1564286,0,size.height*0.2085714);
    path0.cubicTo(size.width*0.1377333,size.height*0.8521429,size.width*0.3532000,size.height*0.9842857,size.width*0.4826667,size.height*0.9828571);
    path0.cubicTo(size.width*0.6181333,size.height*0.9910714,size.width*0.8877333,size.height*0.8096429,size.width,size.height*0.1900000);
    path0.quadraticBezierTo(size.width,size.height*0.1425000,size.width,0);

    canvas.drawPath(path0, paint0);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
