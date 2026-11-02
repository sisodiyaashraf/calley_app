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
import '../../../calling_lists/presentation/widgets/calling_lists_sheet.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../domain/entities/call_stats.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/load_number_card.dart';
import '../widgets/selected_dashboard_view.dart';

/// Screen 6 – Dashboard page displaying load number or selected list stats.
class DashboardPage extends StatelessWidget {
  const DashboardPage({
    super.key, this.onMenuTapped, this.onSupportTapped, this.onNotificationsTapped,
    this.onLinkTapped, this.onWhatsAppTapped, this.onStartCallingTapped,
  });

  final VoidCallback? onMenuTapped, onSupportTapped, onNotificationsTapped;
  final VoidCallback? onLinkTapped, onWhatsAppTapped, onStartCallingTapped;

  void _toast(BuildContext ctx, String msg) => ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
      );

  Widget _errorView(DashboardProvider dash) => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(dash.error!, style: AppTextStyles.cardSubtitle, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: dash.retry, child: const Text(AppStrings.retry)),
        ]),
      );

  Widget _unselected(BuildContext ctx, HomeProvider home, DashboardProvider dash) => Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              ProfileHeaderCard(
                profile: home.profile, greeting: '${AppStrings.helloPrefix}${home.profile?.name ?? ""}',
                title: AppStrings.welcomeToCalley, greetingStyle: AppTextStyles.dashboardGreeting,
                titleStyle: AppTextStyles.dashboardProfileTitle,
                margin: const EdgeInsets.symmetric(horizontal: AppDimens.dashboardCardMargin),
                radius: AppDimens.dashboardHeaderRadius,
              ),
              const SizedBox(height: AppDimens.dashboardHeaderToCardGap),
              LoadNumberCard(
                title: dash.info?.cardTitle ?? AppStrings.loadNumberToCall,
                onLinkTapped: onLinkTapped ?? () => CallingListsSheet.show(ctx, onListSelected: (l) => dash.loadStats(l.id, l.name)),
              ),
            ]),
          ),
        ),
        StartCallingBar(
          margin: const EdgeInsets.symmetric(horizontal: AppDimens.dashboardCardMargin),
          whatsappSize: 46, whatsappIconSize: AppDimens.dashboardActionIconSize, radius: 8, height: 46, gap: 10,
          onWhatsAppTapped: onWhatsAppTapped ?? () => _toast(ctx, AppStrings.whatsAppTappedMessage),
          onStartCallingTapped: onStartCallingTapped ?? () => CallingListsSheet.show(ctx, onListSelected: (l) => dash.loadStats(l.id, l.name)),
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeProvider>(), dash = context.watch<DashboardProvider>();
    final selected = context.watch<CallingListProvider>().selected;

    if (selected != null && dash.stats == null && !dash.isLoadingStats && dash.error == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => dash.loadStats(selected.id, selected.name));
    }

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: DashboardAppBar(
        onMenuTapped: onMenuTapped ?? () => Scaffold.of(context).openDrawer(),
        onSupportTapped: onSupportTapped ?? () => _toast(context, AppStrings.actionSupport),
        onNotificationsTapped: onNotificationsTapped ?? () => _toast(context, AppStrings.actionNotifications),
      ),
      body: SafeArea(
        child: dash.error != null
            ? _errorView(dash)
            : (selected != null
                ? (dash.isLoadingStats && dash.stats == null
                    ? const Center(child: CircularProgressIndicator())
                    : SelectedDashboardView(
                        stats: dash.stats ?? CallStats(listName: selected.name, totalCalls: selected.totalCalls, pending: 0, done: 0, scheduled: 0),
                        onStartCalling: onStartCallingTapped ?? () => _toast(context, AppStrings.actionStartCalling),
                      ))
                : (dash.isLoading && dash.info == null ? const Center(child: CircularProgressIndicator()) : _unselected(context, home, dash))),
      ),
    );
  }
}
