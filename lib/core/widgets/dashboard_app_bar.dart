import 'package:flutter/material.dart';
import '../constants/app_dimens.dart';
import '../constants/app_strings.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Top bar with hamburger menu, title, and support/notification action icons.
class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({
    super.key,
    this.onMenuTapped,
    this.onSupportTapped,
    this.onNotificationsTapped,
    this.title = AppStrings.dashboardTitle,
  });

  final VoidCallback? onMenuTapped;
  final VoidCallback? onSupportTapped;
  final VoidCallback? onNotificationsTapped;
  final String title;

  @override
  Size get preferredSize =>
      const Size.fromHeight(AppDimens.dashboardAppBarHeight);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Container(
        height: AppDimens.dashboardAppBarHeight,
        color: Colors.transparent,
        padding: const EdgeInsets.only(
          left: AppDimens.dashboardCardMargin,
          right: AppDimens.dashboardActionRightMargin,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                children: [
                  InkWell(
                    onTap: onMenuTapped,
                    child: const Icon(
                      Icons.menu,
                      size: AppDimens.dashboardMenuIconSize,
                      color: AppColors.dashboardText,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      title,
                      style: AppTextStyles.dashboardAppBarTitle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: onSupportTapped,
              child: const Icon(
                Icons.headset_mic_outlined,
                size: AppDimens.dashboardActionIconSize,
                color: AppColors.dashboardText,
              ),
            ),
            const SizedBox(width: AppDimens.dashboardActionGap),
            InkWell(
              onTap: onNotificationsTapped,
              child: const Icon(
                Icons.notifications_none,
                size: AppDimens.dashboardActionIconSize,
                color: AppColors.dashboardText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
