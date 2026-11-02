import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/static_screen_data.dart';

/// Central directory screen providing one-tap navigation to every static screen.
class StaticScreensPage extends StatelessWidget {
  const StaticScreensPage({super.key});

  Widget _topBar(BuildContext ctx) => Container(
        height: AppDimens.dashboardAppBarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            InkWell(
              onTap: () => Navigator.maybePop(ctx),
              child: const Icon(Icons.arrow_back_ios_new, size: AppDimens.settingsBackIconSize, color: AppColors.dashboardText),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(AppStrings.staticScreensTitle, style: AppTextStyles.settingsTitle, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      );

  Widget _tile(BuildContext ctx, {required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.cardBorder)),
        child: ListTile(
          leading: Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: AppColors.drawerBackground, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 20, color: AppColors.primary),
          ),
          title: Text(title, style: AppTextStyles.settingsRowLabel),
          subtitle: Text(subtitle, style: AppTextStyles.cardSubtitle),
          trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.fieldIcon),
          onTap: onTap,
        ),
      );

  void _toStatic(BuildContext ctx, StaticScreenData d) => Navigator.pushNamed(ctx, AppRoutes.staticScreen, arguments: d);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Column(
          children: [
            _topBar(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppDimens.horizontalMargin),
                children: [
                  Text('PRIMARY APP SCREENS', style: AppTextStyles.cardTitle),
                  const SizedBox(height: 10),
                  _tile(context, icon: Icons.language, title: 'Screen 1: Choose Language', subtitle: 'Language selection and confirmation', onTap: () => Navigator.pushNamed(context, AppRoutes.language)),
                  _tile(context, icon: Icons.person_add_outlined, title: 'Screen 2: Register', subtitle: 'User registration with 5 fields', onTap: () => Navigator.pushNamed(context, AppRoutes.register)),
                  _tile(context, icon: Icons.mark_email_read_outlined, title: 'Screen 3: WhatsApp OTP', subtitle: '6-box OTP code verification', onTap: () => Navigator.pushNamed(context, AppRoutes.otp, arguments: '+91 9876543210')),
                  _tile(context, icon: Icons.login_outlined, title: 'Screen 4: Sign In', subtitle: 'Email and password authentication', onTap: () => Navigator.pushNamed(context, AppRoutes.signIn)),
                  _tile(context, icon: Icons.home_outlined, title: 'Screen 5: Home Dashboard', subtitle: 'Personal dashboard with video & actions', onTap: () => Navigator.pushNamed(context, AppRoutes.home)),
                  _tile(context, icon: Icons.dashboard_outlined, title: 'Screen 6: Dashboard & Call Stats', subtitle: 'Call stats donut chart and stat tiles', onTap: () => Navigator.pushNamed(context, AppRoutes.dashboard)),
                  _tile(context, icon: Icons.settings_outlined, title: 'Screen 7: Settings', subtitle: 'Profile summary and app settings', onTap: () => Navigator.pushNamed(context, AppRoutes.settings)),
                  const SizedBox(height: 16),
                  Text('DRAWER & AUXILIARY STATIC SCREENS', style: AppTextStyles.cardTitle),
                  const SizedBox(height: 10),
                  _tile(context, icon: Icons.rocket_launch_outlined, title: 'Getting Started', subtitle: 'Quick start guide and web panel upload', onTap: () => _toStatic(context, StaticScreenData.gettingStarted)),
                  _tile(context, icon: Icons.cloud_sync_outlined, title: 'Sync Data', subtitle: 'List synchronization and call logs', onTap: () => Navigator.pushNamed(context, AppRoutes.syncData)),
                  _tile(context, icon: Icons.grid_view_outlined, title: 'Gamification', subtitle: 'Streaks, badges, and caller ranking', onTap: () => _toStatic(context, StaticScreenData.gamification)),
                  _tile(context, icon: Icons.sms_outlined, title: 'Send Logs', subtitle: 'Diagnostics and debugging reports', onTap: () => _toStatic(context, StaticScreenData.sendLogs)),
                  _tile(context, icon: Icons.headset_mic_outlined, title: 'Help & Support', subtitle: 'Customer support contact and FAQs', onTap: () => _toStatic(context, StaticScreenData.help)),
                  _tile(context, icon: Icons.person_off_outlined, title: 'Cancel Subscription', subtitle: 'Subscription terms and management', onTap: () => _toStatic(context, StaticScreenData.cancelSubscription)),
                  _tile(context, icon: Icons.badge_outlined, title: 'About Us', subtitle: 'Calley dialer details and credits', onTap: () => _toStatic(context, StaticScreenData.aboutUs)),
                  _tile(context, icon: Icons.privacy_tip_outlined, title: 'Privacy Policy', subtitle: 'Data protection and caller privacy', onTap: () => _toStatic(context, StaticScreenData.privacyPolicy)),
                  _tile(context, icon: Icons.lock_outline, title: 'Change Password', subtitle: 'Credentials reset instructions', onTap: () => _toStatic(context, StaticScreenData.changePassword)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
