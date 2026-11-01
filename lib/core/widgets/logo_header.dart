import 'package:flutter/material.dart';
import '../constants/app_assets.dart';
import '../constants/app_dimens.dart';

/// Centred logo header used on Screens 2, 3, and 4.
/// Renders [AppAssets.calleyLogo] via Image.asset, fit contain.
class LogoHeader extends StatelessWidget {
  const LogoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppAssets.calleyLogo,
        width: AppDimens.logoWidth,
        fit: BoxFit.contain,
      ),
    );
  }
}
