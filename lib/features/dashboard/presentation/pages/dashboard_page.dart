import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/dashboard_app_bar.dart';
import '../../../../core/widgets/profile_header_card.dart';
import '../../../../core/widgets/start_calling_bar.dart';
import '../../../calling_lists/presentation/providers/calling_list_provider.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../domain/entities/call_stats.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/load_number_card.dart';
import '../widgets/selected_dashboard_view.dart';

/// Screen 6 – Dashboard page displaying either load number or selected list stats.
class DashboardPage extends StatelessWidget {
  const DashboardPage({
    super.key,
    this.onMenuTapped, this.onSupportTapped, this.onNotificationsTapped,
    this.onLinkTapped, this.onWhatsAppTapped, this.onStartCallingTapped,
  });

  final VoidCallback? onMenuTapped, onSupportTapped, onNotificationsTapped;
  final VoidCallback? onLinkTapped, onWhatsAppTapped, onStartCallingTapped;

  void _toast(BuildContext ctx, String msg) => ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
      );

  Widget _unselected(BuildContext ctx, HomeProvider home, DashboardProvider dash) => Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProfileHeaderCard(
                    profile: home.profile,
                    greeting: '${AppStrings.helloPrefix}${home.profile?.name ?? ""}',
                    title: AppStrings.welcomeToCalley,
                    greetingStyle: AppTextStyles.dashboardGreeting,
                    titleStyle: AppTextStyles.dashboardProfileTitle,
                    margin: const EdgeInsets.symmetric(horizontal: AppDimens.dashboardCardMargin),
                    radius: AppDimens.dashboardHeaderRadius,
                  ),
                  const SizedBox(height: AppDimens.dashboardHeaderToCardGap),
                  LoadNumberCard(
                    title: dash.info?.cardTitle ?? AppStrings.loadNumberToCall,
                    onLinkTapped: onLinkTapped ?? () => _toast(ctx, 'onLinkTapped'),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          StartCallingBar(
            margin: const EdgeInsets.symmetric(horizontal: AppDimens.dashboardCardMargin),
            whatsappSize: 46, whatsappIconSize: AppDimens.dashboardActionIconSize,
            radius: 8, height: 46, gap: 10,
            onWhatsAppTapped: onWhatsAppTapped ?? () => _toast(ctx, 'onWhatsAppTapped'),
            onStartCallingTapped: onStartCallingTapped ?? () => _toast(ctx, 'onStartCallingTapped'),
          ),
          const SizedBox(height: 10),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeProvider>();
    final dash = context.watch<DashboardProvider>();
    final listP = context.watch<CallingListProvider>();
    final selected = listP.selected;

    if (selected != null && dash.stats == null && !dash.isLoadingStats) {
      WidgetsBinding.instance.addPostFrameCallback((_) => dash.loadStats(selected.id));
    }

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: DashboardAppBar(
        onMenuTapped: onMenuTapped ?? () => _toast(context, 'onMenuTapped'),
        onSupportTapped: onSupportTapped ?? () => _toast(context, 'onSupportTapped'),
        onNotificationsTapped: onNotificationsTapped ?? () => _toast(context, 'onNotificationsTapped'),
      ),
      body: SafeArea(
        child: selected != null
            ? (dash.isLoadingStats && dash.stats == null
                ? const Center(child: CircularProgressIndicator())
                : SelectedDashboardView(
                    stats: dash.stats ?? CallStats(listName: selected.name, totalCalls: selected.totalCalls, pending: 0, done: 0, scheduled: 0),
                    onStartCalling: onStartCallingTapped ?? () => _toast(context, 'onStartCallingTapped'),
                  ))
            : (dash.isLoading && dash.info == null ? const Center(child: CircularProgressIndicator()) : _unselected(context, home, dash)),
      ),
    );
  }
}
