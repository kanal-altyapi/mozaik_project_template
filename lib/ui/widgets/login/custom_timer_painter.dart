import 'dart:math' as math;
import 'package:flutter/material.dart';


class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
   required this.animation,
   required this.fillColor,
   required this.color,
    this.strokeWidth,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color fillColor, color;
  final double? strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = fillColor
      ..strokeWidth = strokeWidth ?? 5.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    final double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter oldDelegate) {
    return animation.value != oldDelegate.animation.value ||
        color != oldDelegate.color ||
        fillColor != oldDelegate.fillColor;
  }
}