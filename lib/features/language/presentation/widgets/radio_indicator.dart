import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';

/// A 16 × 16 radio indicator dot.
/// [selected] true → filled black dot inside the ring.
class RadioIndicator extends StatelessWidget {
  const RadioIndicator({super.key, required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimens.radioSize,
      height: AppDimens.radioSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.radioBorder,
          width: AppDimens.radioBorderWidth,
        ),
      ),
      child: selected
          ? Center(
              child: Container(
                width: AppDimens.radioDotSize,
                height: AppDimens.radioDotSize,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.radioDot,
                ),
              ),
            )
          : null,
    );
  }
}
