import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/dashboard_app_bar.dart';
import '../../../../core/widgets/profile_header_card.dart';
import '../../../../core/widgets/start_calling_bar.dart';
import '../providers/home_provider.dart';
import '../widgets/first_time_info_card.dart';

/// Screen 5 – Home ("Calley Personal" dashboard with drawer toggle and calling actions).
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    this.onMenuTapped,
    this.onSupportTapped,
    this.onNotificationsTapped,
    this.onVideoTapped,
    this.onWhatsAppTapped,
    this.onStartCallingTapped,
  });

  final VoidCallback? onMenuTapped;
  final VoidCallback? onSupportTapped;
  final VoidCallback? onNotificationsTapped;
  final VoidCallback? onVideoTapped;
  final VoidCallback? onWhatsAppTapped;
  final VoidCallback? onStartCallingTapped;

  void _toast(BuildContext ctx, String msg) => ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
      );

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: DashboardAppBar(
        title: AppStrings.tabHome,
        onMenuTapped: onMenuTapped ?? () => Scaffold.of(context).openDrawer(),
        onSupportTapped: onSupportTapped ?? () => _toast(context, AppStrings.actionSupport),
        onNotificationsTapped: onNotificationsTapped ?? () => _toast(context, AppStrings.actionNotifications),
      ),
      body: SafeArea(
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: AppDimens.homePageHorizontalMargin),
                      child: Column(
                        children: [
                          const SizedBox(height: AppDimens.homeTopMargin),
                          ProfileHeaderCard(profile: provider.profile),
                          const SizedBox(height: AppDimens.homeHeaderToInfoGap),
                          FirstTimeInfoCard(
                            onVideoTapped: onVideoTapped ?? () => _toast(context, AppStrings.videoTappedMessage),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  StartCallingBar(
                    onWhatsAppTapped: onWhatsAppTapped ?? () => _toast(context, AppStrings.whatsAppTappedMessage),
                    onStartCallingTapped: onStartCallingTapped ?? () => _toast(context, AppStrings.startCallingTappedMessage),
                  ),
                  const SizedBox(height: AppDimens.homeBottomBarBottomClearance),
                ],
              ),
      ),
    );
  }
}
