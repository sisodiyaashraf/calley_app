import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/session/pending_registration.dart';
import '../../../../core/session/session.dart';
import '../../../../core/session/session_storage.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../../static_screens/domain/entities/static_screen_data.dart';
import '../../domain/entities/drawer_item.dart';
import '../providers/drawer_provider.dart';
import 'drawer_header_card.dart';
import 'drawer_menu_item.dart';
import 'drawer_section_title.dart';
import 'logout_confirm_dialog.dart';

/// Side navigation drawer composing user profile header, actions, and app info.
class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key, this.onDashboardTapped, this.onGettingStartedTapped, this.onGamificationTapped,
    this.onSendLogsTapped, this.onHelpTapped, this.onCancelSubscriptionTapped, this.onAboutUsTapped, this.onPrivacyPolicyTapped,
    this.onSettingsTapped, this.onShareAppTapped, this.onLogoutTapped,
  });

  final VoidCallback? onDashboardTapped, onGettingStartedTapped, onGamificationTapped,
      onSendLogsTapped, onHelpTapped, onCancelSubscriptionTapped, onAboutUsTapped, onPrivacyPolicyTapped, onSettingsTapped, onShareAppTapped, onLogoutTapped;

  void _navOrCb(BuildContext ctx, VoidCallback? cb, StaticScreenData data) =>
      cb != null ? cb() : Navigator.of(ctx).pushNamed(AppRoutes.staticScreen, arguments: data);

  Future<void> _handleTap(BuildContext context, DrawerItem item) async {
    if (!item.isTappable) return;
    DrawerProvider? drawer;
    try { drawer = context.read<DrawerProvider>(); drawer.onItemTapped(item.id); } catch (_) {}
    if (item.id == 'sync_data') return drawer != null ? drawer.syncData(context) : Navigator.of(context).pop();
    if (item.id != 'logout') Navigator.of(context).pop();

    switch (item.id) {
      case 'settings': onSettingsTapped != null ? onSettingsTapped!() : AppRouter.toSettings(context); break;
      case 'share_app': onShareAppTapped != null ? onShareAppTapped!() : SharePlus.instance.share(ShareParams(text: AppStrings.drawerShareText)); break;
      case 'logout':
        if (onLogoutTapped != null) return onLogoutTapped!();
        final confirmed = await LogoutConfirmDialog.show(context);
        if (confirmed == true && context.mounted) {
          try { context.read<Session?>()?.clear(); } catch (_) {}
          Session.instance.clear(); await SessionStorage.clear(); PendingRegistration.clear();
          if (drawer != null) await drawer.logout();
          if (context.mounted) AppRouter.toLanguage(context);
        }
        break;
      case 'getting_started': onGettingStartedTapped != null ? onGettingStartedTapped!() : AppRouter.toHome(context); break;
      case 'gamification': _navOrCb(context, onGamificationTapped, StaticScreenData.gamification); break;
      case 'send_logs': _navOrCb(context, onSendLogsTapped, StaticScreenData.sendLogs); break;
      case 'help': _navOrCb(context, onHelpTapped, StaticScreenData.help); break;
      case 'cancel_subscription': _navOrCb(context, onCancelSubscriptionTapped, StaticScreenData.cancelSubscription); break;
      case 'about_us': _navOrCb(context, onAboutUsTapped, StaticScreenData.aboutUs); break;
      case 'privacy_policy': _navOrCb(context, onPrivacyPolicyTapped, StaticScreenData.privacyPolicy); break;
    }
  }

  @override
  Widget build(BuildContext context) {
    HomeProvider? home; DrawerProvider? drawer;
    try { home = context.watch<HomeProvider>(); } catch (_) {}
    try { drawer = context.watch<DrawerProvider>(); } catch (_) {}
    final main = drawer?.mainItems ?? const <DrawerItem>[];
    final info = drawer?.appInfoItems ?? const <DrawerItem>[];

    return Drawer(
      width: MediaQuery.of(context).size.width * AppDimens.drawerWidthFactor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(AppDimens.drawerRadius))),
      clipBehavior: Clip.antiAlias,
      backgroundColor: AppColors.drawerBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeaderCard(profile: home?.profile),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...main.map((item) => DrawerMenuItem(item: item, onTap: () => _handleTap(context, item))),
                  const Divider(height: 1, thickness: 1, color: AppColors.drawerDivider),
                  const DrawerSectionTitle(title: AppStrings.drawerAppInfo),
                  ...info.map((item) => DrawerMenuItem(item: item, onTap: () => _handleTap(context, item))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
