import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:outline_pie_chart/outline_pie_chart.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/call_stats.dart';

/// Animated donut / pie chart powered by [PieChartWidget] from outline_pie_chart,
/// displaying Done, Scheduled, and Pending call segments matching reference UI,
/// with the purple segment accentuated with a wider radial thickness (48px vs 28px).
class CallDonutChart extends StatelessWidget {
  const CallDonutChart({super.key, required this.stats});

  final CallStats stats;

  @override
  Widget build(BuildContext context) {
    final sum = stats.done + stats.scheduled + stats.pending;
    final total = sum > 0
        ? sum.toDouble()
        : (stats.totalCalls > 0 ? stats.totalCalls.toDouble() : 1.0);

    // In the reference screenshot (368x711):
    // 1st segment (12 o'clock clockwise to ~5:30): Blue (#1F74EC, ~47.5%)
    // 2nd segment (~5:30 clockwise to ~7:45): Purple (#9566F2, ~15.2%), radial width = 48px
    // 3rd segment (~7:45 clockwise to 12:00): Orange (#FAAB3C, ~37.3%)
    final blueCount = stats.pending > stats.done ? stats.pending : stats.done;
    final orangeCount = stats.pending > stats.done ? stats.done : stats.pending;

    final bluePct = blueCount / total;
    final purplePct = stats.scheduled / total;
    final orangePct = orangeCount / total;

    final data = <PieData>[
      if (bluePct > 0)
        PieData(
          percentage: bluePct,
          color: AppColors.donutDone,
        ),
      if (purplePct > 0)
        PieData(
          percentage: purplePct,
          color: AppColors.donutScheduled,
        ),
      if (orangePct > 0)
        PieData(
          percentage: orangePct,
          color: AppColors.donutPending,
        ),
    ];

    final chartData = data.isNotEmpty
        ? data
        : [PieData(percentage: 1.0, color: AppColors.cardBorder)];

    const double baseDiameter = 174.0;
    const double baseStrokeWidth = 28.0;
    const double purpleStrokeWidth = 48.0;
    const double gapDeg = 4.0;

    // Angle calculation for the purple segment:
    // Starts right after the Blue segment (start at -90 deg):
    final purpleStartDeg = -90.0 + (bluePct * 360.0);
    final purpleSweepDeg = (purplePct * 360.0) - gapDeg;

    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
        builder: (context, animValue, _) {
          return PieChartWidget(
            key: ValueKey('${chartData.length}_${stats.done}_${stats.scheduled}_${stats.pending}'),
            data: chartData,
            diameter: baseDiameter,
            strokeWidth: baseStrokeWidth,
            gap: gapDeg,
            enableAnimation: true,
            animationDuration: const Duration(milliseconds: 700),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                // Inner center circle (96px, #F4F5F7)
                Container(
                  width: 96,
                  height: 96,
                  decoration: const BoxDecoration(
                    color: AppColors.donutHole,
                    shape: BoxShape.circle,
                  ),
                ),
                // Accentuated thick purple portion matching image radial width
                if (purplePct > 0)
                  CustomPaint(
                    size: const Size(baseDiameter - gapDeg, baseDiameter - gapDeg),
                    painter: _ThickPurpleArcPainter(
                      startAngleDeg: purpleStartDeg,
                      sweepAngleDeg: purpleSweepDeg * animValue,
                      strokeWidth: purpleStrokeWidth,
                      color: AppColors.donutScheduled,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ThickPurpleArcPainter extends CustomPainter {
  const _ThickPurpleArcPainter({
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
  bool shouldRepaint(covariant _ThickPurpleArcPainter old) =>
      old.startAngleDeg != startAngleDeg ||
      old.sweepAngleDeg != sweepAngleDeg ||
      old.strokeWidth != strokeWidth ||
      old.color != color;
}
