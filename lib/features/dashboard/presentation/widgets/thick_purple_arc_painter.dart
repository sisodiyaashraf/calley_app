import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Painter rendering the accentuated thick purple arc segment of the donut chart.
class ThickPurpleArcPainter extends CustomPainter {
  const ThickPurpleArcPainter({
    required this.startAngleDeg,
    required this.sweepAngleDeg,
    required this.strokeWidth,
    required this.color,
  });

  final double startAngleDeg;
  final double sweepAngleDeg;
  final double strokeWidth;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    if (sweepAngleDeg <= 0) return;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color
      ..strokeCap = StrokeCap.butt;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final startRad = startAngleDeg * (math.pi / 180.0);
    final sweepRad = sweepAngleDeg * (math.pi / 180.0);
    canvas.drawArc(rect, startRad, sweepRad, false, paint);
  }

  @override
  bool shouldRepaint(covariant ThickPurpleArcPainter old) =>
      old.startAngleDeg != startAngleDeg ||
      old.sweepAngleDeg != sweepAngleDeg ||
      old.strokeWidth != strokeWidth ||
      old.color != color;
}
