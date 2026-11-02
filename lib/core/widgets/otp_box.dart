import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_dimens.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Single-digit input box with active focus and error border styling.
class OtpBox extends StatelessWidget {
  const OtpBox({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    this.hasError = false,
    this.isLast = false,
    this.size,
    this.gap,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final bool hasError, isLast;
  final double? size, gap;

  @override
  Widget build(BuildContext context) {
    final focused = focusNode.hasFocus;
    final color = hasError
        ? AppColors.errorText
        : (focused ? AppColors.primary : AppColors.fieldBorder);
    final width = focused
        ? AppDimens.otpBoxFocusedBorderWidth
        : AppDimens.otpBoxBorderWidth;
    final boxSize = size ?? AppDimens.otpBoxSize;

    return Container(
      width: boxSize,
      height: boxSize,
      margin: EdgeInsets.only(right: isLast ? 0 : (gap ?? AppDimens.otpBoxGap)),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimens.otpBoxRadius),
        border: Border.all(color: color, width: width),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          showCursor: false,
          style: AppTextStyles.otpDigit,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
