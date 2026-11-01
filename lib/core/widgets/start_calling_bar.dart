import 'package:flutter/material.dart';
import '../constants/app_dimens.dart';
import '../constants/app_strings.dart';
import '../theme/app_text_styles.dart';
import 'primary_button.dart';
import 'whatsapp_action_button.dart';

/// Bottom bar containing WhatsApp support action and primary start-calling button.
class StartCallingBar extends StatelessWidget {
  const StartCallingBar({
    super.key,
    this.onWhatsAppTapped,
    this.onStartCallingTapped,
    this.buttonLabel,
    this.margin,
    this.height,
    this.radius,
    this.whatsappSize,
    this.whatsappIconSize,
    this.gap,
  });

  final VoidCallback? onWhatsAppTapped;
  final VoidCallback? onStartCallingTapped;
  final String? buttonLabel;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final double? radius;
  final double? whatsappSize;
  final double? whatsappIconSize;
  final double? gap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ??
          const EdgeInsets.symmetric(
            horizontal: AppDimens.homeBottomBarMargin,
          ),
      child: Row(
        children: [
          WhatsAppActionButton(
            onTap: onWhatsAppTapped,
            size: whatsappSize,
            iconSize: whatsappIconSize,
            radius: radius,
          ),
          SizedBox(width: gap ?? AppDimens.whatsappToStartCallingGap),
          Expanded(
            child: PrimaryButton(
              label: buttonLabel ?? AppStrings.startCallingNow,
              height: height ?? AppDimens.startCallingButtonHeight,
              radius: radius ?? AppDimens.startCallingButtonRadius,
              textStyle: AppTextStyles.startCallingButton,
              onPressed: onStartCallingTapped,
            ),
          ),
        ],
      ),
    );
  }
}
