import 'package:flutter/material.dart';
import 'package:outline_pie_chart/outline_pie_chart.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/call_stats.dart';
import 'thick_purple_arc_painter.dart';

/// Animated donut chart displaying Done, Scheduled, and Pending call segments.
class CallDonutChart extends StatelessWidget {
  const CallDonutChart({super.key, required this.stats});

  final CallStats stats;

  @override
  Widget build(BuildContext context) {
    final sum = stats.done + stats.scheduled + stats.pending;
    final total = sum > 0 ? sum.toDouble() : (stats.totalCalls > 0 ? stats.totalCalls.toDouble() : 1.0);
    final blueCount = stats.pending > stats.done ? stats.pending : stats.done;
    final orangeCount = stats.pending > stats.done ? stats.done : stats.pending;
    final bluePct = blueCount / total, purplePct = stats.scheduled / total, orangePct = orangeCount / total;

    final data = <PieData>[
      if (bluePct > 0) PieData(percentage: bluePct, color: AppColors.donutDone),
      if (purplePct > 0) PieData(percentage: purplePct, color: AppColors.donutScheduled),
      if (orangePct > 0) PieData(percentage: orangePct, color: AppColors.donutPending),
    ];
    final chartData = data.isNotEmpty ? data : [PieData(percentage: 1.0, color: AppColors.cardBorder)];

    const double baseDiameter = 174.0, baseStrokeWidth = 28.0, purpleStrokeWidth = 48.0, gapDeg = 4.0;
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
                Container(
                  width: 96,
                  height: 96,
                  decoration: const BoxDecoration(color: AppColors.donutHole, shape: BoxShape.circle),
                ),
                if (purplePct > 0)
                  CustomPaint(
                    size: const Size(baseDiameter - gapDeg, baseDiameter - gapDeg),
                    painter: ThickPurpleArcPainter(
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
