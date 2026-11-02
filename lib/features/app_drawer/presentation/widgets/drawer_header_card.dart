import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/session/session.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../home/domain/entities/user_profile.dart';

/// Blue header of the drawer showing the user avatar, name, plan, and email.
class DrawerHeaderCard extends StatelessWidget {
  const DrawerHeaderCard({super.key, this.profile});

  final UserProfile? profile;

  @override
  Widget build(BuildContext context) {
    final session = context.watch<Session?>();
    final name = (session != null && !session.isEmpty)
        ? session.displayName
        : (profile?.name.isNotEmpty ?? false ? profile!.name : 'Guest');
    final email = (session != null && !session.isEmpty)
        ? session.email
        : (profile?.email.isNotEmpty ?? false ? profile!.email : '');
    final rawPlan = profile?.subscription ?? 'Calley Personal';
    final plan = rawPlan.replaceAll('Calley', '').trim();
    final displayPlan = plan.isNotEmpty ? plan : 'Personal';
    final topSafe = MediaQuery.of(context).padding.top;

    return Container(
      color: AppColors.primary,
      padding: EdgeInsets.fromLTRB(
        AppDimens.drawerHeaderPadding,
        topSafe + AppDimens.drawerHeaderPadding,
        AppDimens.drawerHeaderPadding,
        AppDimens.drawerHeaderPadding,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              AppAssets.profileCalley,
              width: AppDimens.drawerAvatarSize,
              height: AppDimens.drawerAvatarSize,
              fit: BoxFit.cover,
              errorBuilder: (ctx, err, stack) => const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: AppDimens.drawerAvatarGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(
                  TextSpan(
                    text: name,
                    style: AppTextStyles.drawerHeaderName,
                    children: [
                      TextSpan(
                        text: '  • $displayPlan',
                        style: AppTextStyles.drawerHeaderPlan,
                      ),
                    ],
                  ),
                ),
                if (email.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(email, style: AppTextStyles.drawerHeaderEmail),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
