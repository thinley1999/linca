import 'package:flutter/material.dart';

class Point{
  final double x;
  final double y;
  Point(this.x, this.y);
}


class BackgroundPainter extends CustomPainter{
  final Paint second;

  BackgroundPainter()
        :second= Paint()
          ..color = Color(0xFF76FF03)
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size){
    secondd(size, canvas);

  }

  void secondd(Size size, Canvas canvas){
    final path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height * 0.6);

    _dpath(path,
        [
          Point(
            size.width * 0.5,
            size.height * 0.65,
          ),

          Point(
            size.width * 0.7,
            size.height * 0.2,
          ),


          Point(
            size.width ,
            size.height * 0.15,
          ),
        ],);

    canvas.drawPath(path, second);
  }

  void _dpath(Path path, List<Point> points){
  if(points.length<3){
    throw UnsupportedError('3+ ponts required to create path ');
  }

  for(var i = 0; i<points.length-2; i++){
    final xd = (points[i].x + points[i+1].x)/2;
    final yd = (points[i].y + points[i+1].y)/2;
    path.quadraticBezierTo(
      points[i].x, points[i].y, xd, yd);
  }
  final secondl = points[points.length -2];
  final second2 = points[points.length -1];
  path.quadraticBezierTo(
    secondl.x, secondl.y, second2.x, second2.y);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate)=> true;
}
