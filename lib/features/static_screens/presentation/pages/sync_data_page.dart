import 'package:flutter/material.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';

/// Dedicated static screen for Calley Cloud data synchronization.
class SyncDataPage extends StatefulWidget {
  const SyncDataPage({super.key});
  @override
  State<SyncDataPage> createState() => _SyncDataPageState();
}

class _SyncDataPageState extends State<SyncDataPage> {
  bool _wifiOnly = false, _syncing = false;

  Widget _topBar(BuildContext ctx) => Container(
        height: AppDimens.dashboardAppBarHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(children: [
          InkWell(onTap: () => Navigator.maybePop(ctx), child: const Icon(Icons.arrow_back_ios_new, size: AppDimens.settingsBackIconSize, color: AppColors.dashboardText)),
          const SizedBox(width: 12),
          Expanded(child: Text(AppStrings.drawerSyncData, style: AppTextStyles.settingsTitle, overflow: TextOverflow.ellipsis)),
        ]),
      );

  Widget _syncRow(IconData icon, String title, String subtitle) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.cardBorder)),
        child: Row(children: [
          Icon(icon, color: AppColors.primary, size: 22),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTextStyles.settingsRowLabel),
            Text(subtitle, style: AppTextStyles.cardSubtitle),
          ])),
          const Icon(Icons.check_circle, color: AppColors.statDoneBar, size: 18),
        ]),
      );

  Future<void> _handleSync() async {
    setState(() => _syncing = true);
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    setState(() => _syncing = false);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All lists and call records synchronized!'), duration: Duration(seconds: 2)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: Column(children: [
          _topBar(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(AppDimens.horizontalMargin),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.cardBorder)),
                  child: Column(children: [
                    const Icon(Icons.cloud_sync_outlined, size: 48, color: AppColors.primary),
                    const SizedBox(height: 10),
                    Text('Calley Cloud Sync', style: AppTextStyles.cardTitle),
                    const SizedBox(height: 4),
                    Text('Keep your calling lists and logs updated', style: AppTextStyles.cardSubtitle),
                    const SizedBox(height: 8),
                    Text('Last Synced: Today at 10:45 AM', style: AppTextStyles.richLinkBody),
                  ]),
                ),
                const SizedBox(height: 16),
                Text('SYNCHRONIZATION ITEMS', style: AppTextStyles.cardTitle),
                const SizedBox(height: 8),
                _syncRow(Icons.format_list_bulleted, 'Calling Lists', '3 lists up to date'),
                _syncRow(Icons.history, 'Call Logs & Audio', 'All call history backed up'),
                _syncRow(Icons.assignment_turned_in_outlined, 'Dispositions & Feedback', 'Notes & call statuses synced'),
                const SizedBox(height: 12),
                SwitchListTile.adaptive(
                  value: _wifiOnly, onChanged: (v) => setState(() => _wifiOnly = v),
                  title: Text('Sync over Wi-Fi only', style: AppTextStyles.settingsRowLabel),
                  dense: true, contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimens.horizontalMargin),
            child: PrimaryButton(label: _syncing ? 'Syncing...' : 'Sync Now', isLoading: _syncing, onPressed: _syncing ? null : _handleSync),
          ),
        ]),
      ),
    );
  }
}
