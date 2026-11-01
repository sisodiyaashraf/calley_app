import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Compact button with spinning refresh icon while refreshing.
class RefreshButton extends StatefulWidget {
  const RefreshButton({
    super.key,
    required this.isRefreshing,
    required this.onPressed,
  });

  final bool isRefreshing;
  final VoidCallback? onPressed;

  @override
  State<RefreshButton> createState() => _RefreshButtonState();
}

class _RefreshButtonState extends State<RefreshButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    if (widget.isRefreshing) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant RefreshButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRefreshing != oldWidget.isRefreshing) {
      if (widget.isRefreshing) {
        _controller.repeat();
      } else {
        _controller.stop();
        _controller.reset();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.isRefreshing ? null : widget.onPressed,
      borderRadius: BorderRadius.circular(AppDimens.refreshButtonRadius),
      child: Container(
        height: AppDimens.refreshButtonHeight,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.refreshButtonHPadding,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppDimens.refreshButtonRadius),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            RotationTransition(
              turns: _controller,
              child: const Icon(
                Icons.refresh,
                size: AppDimens.refreshIconSize,
                color: AppColors.whiteText,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              AppStrings.refresh,
              style: AppTextStyles.refreshButtonText,
            ),
          ],
        ),
      ),
    );
  }
}
