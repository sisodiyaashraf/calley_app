import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

/// Centred RichText row: plain [prefixText] followed by a tappable [linkText].
class AuthLinkText extends StatelessWidget {
  const AuthLinkText({
    super.key,
    required this.prefixText,
    required this.linkText,
    required this.onLinkTap,
    this.style,
    this.linkStyle,
  });

  final String prefixText;
  final String linkText;
  final VoidCallback onLinkTap;
  final TextStyle? style;
  final TextStyle? linkStyle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onLinkTap,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: style ?? AppTextStyles.termsText,
            children: [
              TextSpan(text: prefixText),
              TextSpan(
                text: linkText,
                style: linkStyle ?? AppTextStyles.termsLink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
