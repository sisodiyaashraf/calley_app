import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/profile_header_card.dart';
import '../../../../core/widgets/start_calling_bar.dart';
import '../providers/home_provider.dart';
import '../widgets/first_time_info_card.dart';

/// Screen 5 – Home ("Calley Personal" dashboard, composes widgets only).
class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    this.onVideoTapped,
    this.onWhatsAppTapped,
    this.onStartCallingTapped,
  });

  final VoidCallback? onVideoTapped;
  final VoidCallback? onWhatsAppTapped;
  final VoidCallback? onStartCallingTapped;

  void _showFeedback(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeProvider>();

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      body: SafeArea(
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.homePageHorizontalMargin,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: AppDimens.homeTopMargin),
                          ProfileHeaderCard(profile: provider.profile),
                          const SizedBox(height: AppDimens.homeHeaderToInfoGap),
                          FirstTimeInfoCard(
                            onVideoTapped: () => onVideoTapped != null
                                ? onVideoTapped!()
                                : _showFeedback(
                                    context, AppStrings.videoTappedMessage),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  StartCallingBar(
                    onWhatsAppTapped: () => onWhatsAppTapped != null
                        ? onWhatsAppTapped!()
                        : _showFeedback(
                            context, AppStrings.whatsAppTappedMessage),
                    onStartCallingTapped: () => onStartCallingTapped != null
                        ? onStartCallingTapped!()
                        : _showFeedback(
                            context, AppStrings.startCallingTappedMessage),
                  ),
                  const SizedBox(
                    height: AppDimens.homeBottomBarBottomClearance,
                  ),
                ],
              ),
      ),
    );
  }
}
