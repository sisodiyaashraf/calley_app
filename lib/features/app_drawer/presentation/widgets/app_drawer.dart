import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../domain/entities/drawer_item.dart';
import '../providers/drawer_provider.dart';
import 'drawer_header_card.dart';
import 'drawer_menu_item.dart';
import 'drawer_section_title.dart';
import 'logout_confirm_dialog.dart';

/// Side navigation drawer composing user profile header, actions, and app info.
class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    this.onGettingStartedTapped, this.onSyncDataTapped, this.onGamificationTapped,
    this.onSendLogsTapped, this.onHelpTapped, this.onCancelSubscriptionTapped,
    this.onAboutUsTapped, this.onPrivacyPolicyTapped, this.onSettingsTapped,
    this.onShareAppTapped, this.onLogoutTapped,
  });

  final VoidCallback? onGettingStartedTapped, onSyncDataTapped, onGamificationTapped;
  final VoidCallback? onSendLogsTapped, onHelpTapped, onCancelSubscriptionTapped;
  final VoidCallback? onAboutUsTapped, onPrivacyPolicyTapped, onSettingsTapped;
  final VoidCallback? onShareAppTapped, onLogoutTapped;

  void _feedback(BuildContext ctx, VoidCallback? cb, String label) =>
      cb != null ? cb() : ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(label), duration: const Duration(seconds: 2)));

  Future<void> _handleTap(BuildContext context, DrawerItem item) async {
    if (!item.isTappable) return;
    Navigator.of(context).pop();
    final drawer = context.read<DrawerProvider>();
    drawer.onItemTapped(item.id);

    switch (item.id) {
      case 'settings': onSettingsTapped != null ? onSettingsTapped!() : Navigator.of(context).pushNamed(AppRoutes.settings); break;
      case 'share_app': onShareAppTapped != null ? onShareAppTapped!() : SharePlus.instance.share(ShareParams(text: AppStrings.drawerShareText)); break;
      case 'logout':
        if (onLogoutTapped != null) { onLogoutTapped!(); } else {
          final confirmed = await LogoutConfirmDialog.show(context);
          if (confirmed == true && context.mounted) {
            await drawer.logout();
            if (context.mounted) Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.signIn, (_) => false);
          }
        }
        break;
      case 'getting_started': _feedback(context, onGettingStartedTapped, item.label); break;
      case 'sync_data': _feedback(context, onSyncDataTapped, item.label); break;
      case 'gamification': _feedback(context, onGamificationTapped, item.label); break;
      case 'send_logs': _feedback(context, onSendLogsTapped, item.label); break;
      case 'help': _feedback(context, onHelpTapped, item.label); break;
      case 'cancel_subscription': _feedback(context, onCancelSubscriptionTapped, item.label); break;
      case 'about_us': _feedback(context, onAboutUsTapped, item.label); break;
      case 'privacy_policy': _feedback(context, onPrivacyPolicyTapped, item.label); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeProvider>();
    final drawer = context.watch<DrawerProvider>();

    return Drawer(
      width: MediaQuery.of(context).size.width * AppDimens.drawerWidthFactor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(AppDimens.drawerRadius), bottomRight: Radius.circular(AppDimens.drawerRadius)),
      ),
      clipBehavior: Clip.antiAlias,
      backgroundColor: AppColors.drawerBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeaderCard(profile: home.profile),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...drawer.mainItems.map((item) => DrawerMenuItem(item: item, onTap: () => _handleTap(context, item))),
                  const Divider(height: 1, thickness: 1, color: AppColors.drawerDivider),
                  const DrawerSectionTitle(title: AppStrings.drawerAppInfo),
                  ...drawer.appInfoItems.map((item) => DrawerMenuItem(item: item, onTap: () => _handleTap(context, item))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
