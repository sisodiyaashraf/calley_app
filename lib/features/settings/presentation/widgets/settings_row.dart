import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/arrow_box_button.dart';
import '../../../../core/widgets/icon_box.dart';

/// Single clickable setting entry with leading icon box and trailing arrow.
class SettingsRow extends StatelessWidget {
  const SettingsRow({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.iconBoxRadius),
      child: SizedBox(
        height: AppDimens.settingsRowHeight,
        child: Row(
          children: [
            IconBox(icon: icon),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.settingsRowLabel,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ArrowBoxButton(onTap: onTap),
          ],
        ),
      ),
    );
  }
}
