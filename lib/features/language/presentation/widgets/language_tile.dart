import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../domain/entities/language.dart';
import 'radio_indicator.dart';

/// A single selectable row inside the language list card.
///
/// Tapping anywhere on the row triggers [onTap].
/// The row has a min height of [AppDimens.tileContentHeight] and a
/// vertical padding of [AppDimens.tileVerticalPadding] on each side,
/// giving the ~64 px pitch specified in the Figma.
class LanguageTile extends StatelessWidget {
  const LanguageTile({
    super.key,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  final Language language;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: AppColors.cardBorder.withValues(alpha: 0.15),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimens.tileVerticalPadding,
        ),
        child: Row(
          children: [
            // Leading horizontal space matching the Figma text-column start
            const SizedBox(width: AppDimens.tileTextStartX),
            // Text column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    language.name,
                    style: AppTextStyles.tileName,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    language.greeting,
                    style: AppTextStyles.tileGreeting,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            RadioIndicator(selected: isSelected),
            const SizedBox(width: AppDimens.tileTextStartX),
          ],
        ),
      ),
    );
  }
}
