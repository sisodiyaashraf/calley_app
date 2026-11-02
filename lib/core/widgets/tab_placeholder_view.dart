import 'package:flutter/material.dart';
import '../constants/app_dimens.dart';
import '../constants/app_strings.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'dashboard_app_bar.dart';
import 'primary_button.dart';

/// Reusable view for secondary tabs providing header, empty state, and action.
class TabPlaceholderView extends StatelessWidget {
  const TabPlaceholderView({
    super.key,
    required this.title,
    required this.icon,
    required this.message,
    this.actionLabel = AppStrings.callingLists,
    this.onAction,
    this.onMenuTapped,
  });

  final String title;
  final IconData icon;
  final String message;
  final String actionLabel;
  final VoidCallback? onAction;
  final VoidCallback? onMenuTapped;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: DashboardAppBar(title: title, onMenuTapped: onMenuTapped),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.horizontalMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 64, color: AppColors.navyCardBackground),
                const SizedBox(height: 16),
                Text(title, style: AppTextStyles.cardTitle, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text(message, style: AppTextStyles.cardSubtitle, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                if (onAction != null)
                  PrimaryButton(label: actionLabel, onPressed: onAction),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
