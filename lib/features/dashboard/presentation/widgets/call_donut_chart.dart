import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../domain/entities/call_stats.dart';
import 'donut_painter.dart';

/// Animated donut chart showing Done, Scheduled, and Pending call segments.
class CallDonutChart extends StatelessWidget {
  const CallDonutChart({super.key, required this.stats});

  final CallStats stats;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppDimens.donutDiameter,
        height: AppDimens.donutDiameter,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOutCubic,
          builder: (context, value, child) {
            return CustomPaint(
              size: const Size(
                AppDimens.donutDiameter,
                AppDimens.donutDiameter,
              ),
              painter: DonutPainter(
                stats: stats,
                progress: value,
                ringThickness: AppDimens.donutRingThickness,
              ),
            );
          },
        ),
      ),
    );
  }
}
