import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/navigation/app_router.dart';
import '../../../../core/session/session.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/url_helper.dart';
import '../../../../core/widgets/dashboard_app_bar.dart';
import '../../../../core/widgets/profile_header_card.dart';
import '../../../../core/widgets/start_calling_bar.dart';
import '../providers/home_provider.dart';
import '../widgets/first_time_info_card.dart';

/// Screen 1 – First-time home page (greeting card, video card, WhatsApp & calling actions).
class FirstTimeHomePage extends StatelessWidget {
  const FirstTimeHomePage({
    super.key,
    this.onMenuTapped,
    this.onSupportTapped,
    this.onNotificationsTapped,
    this.onVideoTapped,
    this.onWhatsAppTapped,
    this.onStartCallingTapped,
  });

  final VoidCallback? onMenuTapped, onSupportTapped, onNotificationsTapped;
  final VoidCallback? onVideoTapped, onWhatsAppTapped, onStartCallingTapped;

  void _toast(BuildContext ctx, String msg) =>
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
      );

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeProvider>();
    final session = context.watch<Session?>();
    final name = (session != null && !session.isEmpty)
        ? session.displayName
        : (home.profile?.name.isNotEmpty ?? false
              ? home.profile!.name
              : 'Guest');

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: DashboardAppBar(
        title: AppStrings.tabHome,
        onMenuTapped: onMenuTapped ?? () => Scaffold.of(context).openDrawer(),
        onSupportTapped:
            onSupportTapped ?? () => _toast(context, AppStrings.actionSupport),
        onNotificationsTapped:
            onNotificationsTapped ??
            () => _toast(context, AppStrings.actionNotifications),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimens.homePageHorizontalMargin,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: AppDimens.homeTopMargin),
                    ProfileHeaderCard(
                      profile: home.profile,
                      greeting: '${AppStrings.helloPrefix}$name',
                    ),
                    const SizedBox(height: AppDimens.homeHeaderToInfoGap),
                    FirstTimeInfoCard(onVideoTapped: onVideoTapped),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            StartCallingBar(
              onWhatsAppTapped:
                  onWhatsAppTapped ?? () => UrlHelper.launchWhatsApp(context),
              onStartCallingTapped:
                  onStartCallingTapped ??
                  () => AppRouter.toDashboardLoad(context),
            ),
            const SizedBox(height: AppDimens.homeBottomBarBottomClearance),
          ],
        ),
      ),
    );
  }
}
