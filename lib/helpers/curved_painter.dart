import 'package:flutter/material.dart';
import 'package:social/constants.dart';

class CurvedPainter extends CustomPainter {
  final double curve;
  CurvedPainter({@required this.curve}) : assert(curve != null);
  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final path = Path();
    final paint = Paint()..color = greyBlue;
    path.moveTo(0, height * curve);
    path.quadraticBezierTo(width/2, 0, width, height * curve);
    path.lineTo(width, height);
    path.lineTo(0, height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
