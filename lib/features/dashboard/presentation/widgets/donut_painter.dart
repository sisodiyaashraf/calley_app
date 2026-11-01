import 'dart:math';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/call_stats.dart';

/// CustomPainter rendering a 3-segment proportional donut chart with rounded caps.
class DonutPainter extends CustomPainter {
  const DonutPainter({
    required this.stats,
    this.progress = 1.0,
    this.ringThickness = 32.0,
  });

  final CallStats stats;
  final double progress;
  final double ringThickness;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - ringThickness) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Center filled circle (~100px diameter, 10px gap to 141px inner ring)
    canvas.drawCircle(
      center,
      50.0,
      Paint()
        ..color = AppColors.donutHole
        ..style = PaintingStyle.fill,
    );

    final segments = [
      (stats.done, AppColors.donutDone),
      (stats.scheduled, AppColors.donutScheduled),
      (stats.pending, AppColors.donutPending),
    ];

    final sum = segments.fold<int>(0, (prev, s) => prev + s.$1);
    if (sum == 0) return;

    final activeCount = segments.where((s) => s.$1 > 0).length;
    final gapRad = activeCount > 1 ? (5.0 * pi / 180.0) : 0.0;
    final available = (2 * pi) - (activeCount * gapRad);

    var startAngle = -pi / 2;

    for (final seg in segments) {
      if (seg.$1 <= 0) continue;
      final sweep = (seg.$1 / sum) * available;
      final paint = Paint()
        ..color = seg.$2
        ..style = PaintingStyle.stroke
        ..strokeWidth = ringThickness
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(rect, startAngle, sweep * progress, false, paint);
      startAngle += sweep + gapRad;
    }
  }

  @override
  bool shouldRepaint(covariant DonutPainter old) =>
      old.stats != stats || old.progress != progress;
}
