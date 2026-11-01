import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Renders a centered text paragraph containing a tappable blue link.
class RichLinkMessage extends StatefulWidget {
  const RichLinkMessage({
    super.key,
    this.prefix = AppStrings.loadNumberPrefix,
    this.url = AppStrings.loadNumberUrl,
    this.suffix = AppStrings.loadNumberSuffix,
    this.onLinkTapped,
  });

  final String prefix;
  final String url;
  final String suffix;
  final VoidCallback? onLinkTapped;

  @override
  State<RichLinkMessage> createState() => _RichLinkMessageState();
}

class _RichLinkMessageState extends State<RichLinkMessage> {
  late final TapGestureRecognizer _recognizer;

  @override
  void initState() {
    super.initState();
    _recognizer = TapGestureRecognizer()
      ..onTap = () => widget.onLinkTapped?.call();
  }

  @override
  void dispose() {
    _recognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTextStyles.richLinkBody,
        children: [
          TextSpan(text: widget.prefix),
          TextSpan(
            text: widget.url,
            style: AppTextStyles.richLinkUrl,
            recognizer: _recognizer,
          ),
          TextSpan(text: widget.suffix),
        ],
      ),
    );
  }
}
