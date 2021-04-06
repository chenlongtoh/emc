import 'package:flutter/material.dart';

class Line extends CustomPainter {
  final lineHeight = 2;
  @override
  void paint(Canvas canvas, Size size) {
    final spacing = (size.height - 3 * lineHeight) / 4;
    final p1 = Offset(0, spacing + lineHeight);
    final p2 = Offset(size.width / 2, spacing + lineHeight);
    final p3 = Offset(0, 2 * spacing + 2 * lineHeight);
    final p4 = Offset(size.width, 2 * spacing + 2 * lineHeight);
    final p5 = Offset(0, 3 * spacing + 3 * lineHeight);
    final p6 = Offset(size.width / 2, 3 * spacing + 3 * lineHeight);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = lineHeight.toDouble();
    canvas.drawLine(p1, p2, paint);
    canvas.drawLine(p3, p4, paint);
    canvas.drawLine(p5, p6, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
