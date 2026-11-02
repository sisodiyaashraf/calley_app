import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/session/session.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/url_helper.dart';
import '../../../../core/widgets/dashboard_app_bar.dart';
import '../../../../core/widgets/profile_header_card.dart';
import '../../../../core/widgets/start_calling_bar.dart';
import '../../../app_drawer/presentation/widgets/app_drawer.dart';
import '../../../calling_lists/presentation/widgets/calling_lists_sheet.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../widgets/load_number_card.dart';

/// Screen 2 – Dashboard Load Page ("LOAD NUMBER TO CALL" card with callersupport.png).
class DashboardLoadPage extends StatelessWidget {
  const DashboardLoadPage({
    super.key,
    this.onMenuTapped,
    this.onSupportTapped,
    this.onNotificationsTapped,
    this.onLinkTapped,
    this.onWhatsAppTapped,
    this.onStartCallingTapped,
  });

  final VoidCallback? onMenuTapped, onSupportTapped, onNotificationsTapped;
  final VoidCallback? onLinkTapped, onWhatsAppTapped, onStartCallingTapped;

  void _toast(BuildContext ctx, String msg) => ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
      );

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeProvider>();
    final session = context.watch<Session?>();
    final name = (session != null && !session.isEmpty)
        ? session.displayName
        : (home.profile?.name.isNotEmpty ?? false ? home.profile!.name : 'Guest');

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      drawerScrimColor: AppColors.drawerScrim,
      drawer: const AppDrawer(),
      appBar: DashboardAppBar(
        onMenuTapped: onMenuTapped,
        onSupportTapped: onSupportTapped ?? () => _toast(context, AppStrings.actionSupport),
        onNotificationsTapped: onNotificationsTapped ?? () => _toast(context, AppStrings.actionNotifications),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileHeaderCard(
                      profile: home.profile,
                      greeting: '${AppStrings.helloPrefix}$name',
                      title: AppStrings.welcomeToCalley,
                      greetingStyle: AppTextStyles.dashboardGreeting,
                      titleStyle: AppTextStyles.dashboardProfileTitle,
                      margin: const EdgeInsets.symmetric(horizontal: AppDimens.dashboardCardMargin),
                      radius: AppDimens.dashboardHeaderRadius,
                    ),
                    const SizedBox(height: AppDimens.dashboardHeaderToCardGap),
                    LoadNumberCard(
                      title: AppStrings.loadNumberToCall,
                      onLinkTapped: onLinkTapped ?? () => CallingListsSheet.show(context),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            StartCallingBar(
              margin: const EdgeInsets.symmetric(horizontal: AppDimens.dashboardCardMargin),
              whatsappSize: 46, whatsappIconSize: AppDimens.dashboardActionIconSize, radius: 8, height: 46, gap: 10,
              onWhatsAppTapped: onWhatsAppTapped ?? () => UrlHelper.launchWhatsApp(context),
              onStartCallingTapped: onStartCallingTapped ?? () => CallingListsSheet.show(context),
            ),
            const SizedBox(height: AppDimens.homeBottomBarBottomClearance),
          ],
        ),
      ),
    );
  }
}
