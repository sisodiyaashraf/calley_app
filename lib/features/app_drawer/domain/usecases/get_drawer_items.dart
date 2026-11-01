import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../entities/drawer_item.dart';

/// Provides the standard list of side navigation drawer menu items.
class GetDrawerItems {
  const GetDrawerItems();

  List<DrawerItem> getMainItems() => const [
        DrawerItem(
          id: 'getting_started',
          label: AppStrings.drawerGettingStarted,
          icon: Icons.rocket_launch_outlined,
        ),
        DrawerItem(
          id: 'sync_data',
          label: AppStrings.drawerSyncData,
          icon: Icons.cloud_sync_outlined,
        ),
        DrawerItem(
          id: 'gamification',
          label: AppStrings.drawerGamification,
          icon: Icons.grid_view_outlined,
        ),
        DrawerItem(
          id: 'send_logs',
          label: AppStrings.drawerSendLogs,
          icon: Icons.sms_outlined,
        ),
        DrawerItem(
          id: 'settings',
          label: AppStrings.drawerSettings,
          icon: Icons.settings_outlined,
        ),
        DrawerItem(
          id: 'help',
          label: AppStrings.drawerHelp,
          icon: Icons.headset_mic_outlined,
        ),
        DrawerItem(
          id: 'cancel_subscription',
          label: AppStrings.drawerCancelSubscription,
          icon: Icons.person_off_outlined,
        ),
      ];

  List<DrawerItem> getAppInfoItems({
    String version = AppStrings.drawerDefaultVersion,
  }) =>
      [
        const DrawerItem(
          id: 'about_us',
          label: AppStrings.drawerAboutUs,
          icon: Icons.badge_outlined,
        ),
        const DrawerItem(
          id: 'privacy_policy',
          label: AppStrings.drawerPrivacyPolicy,
          icon: Icons.privacy_tip_outlined,
        ),
        DrawerItem(
          id: 'version',
          label: '${AppStrings.drawerVersionPrefix} $version',
          icon: Icons.phone_android_outlined,
          isTappable: false,
        ),
        const DrawerItem(
          id: 'share_app',
          label: AppStrings.drawerShareApp,
          icon: Icons.share_outlined,
        ),
        const DrawerItem(
          id: 'logout',
          label: AppStrings.drawerLogout,
          icon: Icons.logout,
          isDestructive: true,
        ),
      ];
}
