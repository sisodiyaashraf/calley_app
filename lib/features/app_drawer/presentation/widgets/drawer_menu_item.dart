import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/drawer_item.dart';

/// Single item in the side drawer with a white pill icon box and label.
class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem({
    super.key,
    required this.item,
    this.onTap,
  });

  final DrawerItem item;
  final VoidCallback? onTap;

  /// Icon builder method to easily swap Material icons with SVGs.
  Widget _buildIcon(BuildContext context) {
    return Icon(
      item.icon,
      size: AppDimens.drawerIconSize,
      color: AppColors.dashboardText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimens.drawerRowHeight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: item.isTappable ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: AppDimens.drawerPillWidth,
                  height: AppDimens.drawerPillHeight,
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(
                      AppDimens.drawerPillRadius,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: _buildIcon(context),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    item.label,
                    style: AppTextStyles.drawerMenuItem,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
