import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../providers/language_provider.dart';
import 'language_tile.dart';

/// Rounded card containing the scrollable language list.
///
/// The card expands to fill the available space between the title and the
/// button. If content is taller than the available space (small screens),
/// it scrolls internally – no overflow is possible.
class LanguageListCard extends StatelessWidget {
  const LanguageListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimens.cardBorderRadius),
        border: Border.all(
          color: AppColors.cardBorder,
          width: AppDimens.cardBorderWidth,
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardShadow,
            offset: Offset(0, AppDimens.cardShadowOffsetY),
            blurRadius: AppDimens.cardShadowBlur,
          ),
        ],
      ),
      child: Selector<LanguageProvider, ({List languages, int selectedIndex})>(
          selector: (_, p) => (languages: p.languages, selectedIndex: p.selectedIndex),
          builder: (context, data, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppDimens.cardVerticalPadding,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  data.languages.length,
                  (index) => LanguageTile(
                    language: data.languages[index],
                    isSelected: index == data.selectedIndex,
                    onTap: () => context.read<LanguageProvider>().select(index),
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}
