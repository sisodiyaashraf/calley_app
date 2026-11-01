import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_dimens.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Reusable text field used on Register and Sign In screens.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key, required this.hint, this.controller, this.initialValue,
    this.trailingIcon, this.obscureText = false, this.readOnly = false,
    this.errorText, this.keyboardType = TextInputType.text,
    this.inputFormatters, this.onChanged, this.textInputAction, this.onSubmitted,
  });

  final String hint;
  final TextEditingController? controller;
  final String? initialValue, errorText;
  final Widget? trailingIcon;
  final bool obscureText, readOnly;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged, onSubmitted;
  final TextInputAction? textInputAction;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscured;
  TextEditingController? _internal;

  TextEditingController get _ctrl => widget.controller ??
      (_internal ??= TextEditingController(text: widget.initialValue));

  @override
  void initState() {
    super.initState();
    _obscured = widget.obscureText;
  }

  @override
  void dispose() {
    _internal?.dispose();
    super.dispose();
  }

  Widget? _buildSuffix() {
    if (!widget.obscureText) return widget.trailingIcon;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _obscured = !_obscured),
      child: Icon(
        _obscured ? Icons.lock_outline : Icons.lock_open_outlined,
        size: AppDimens.fieldIconSize, color: AppColors.fieldIcon,
      ),
    );
  }

  OutlineInputBorder _border([Color c = AppColors.fieldBorder]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDimens.fieldBorderRadius),
        borderSide: BorderSide(color: c, width: AppDimens.fieldBorderWidth),
      );

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: AppDimens.fieldHeight,
            child: TextField(
              controller: _ctrl, obscureText: _obscured, readOnly: widget.readOnly,
              keyboardType: widget.keyboardType, textInputAction: widget.textInputAction,
              onSubmitted: widget.onSubmitted, inputFormatters: widget.inputFormatters,
              onChanged: widget.onChanged, style: AppTextStyles.fieldText,
              decoration: InputDecoration(
                isDense: true, hintText: widget.hint, hintStyle: AppTextStyles.fieldHint,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppDimens.fieldHPadding, vertical: 14),
                filled: true, fillColor: AppColors.cardBackground,
                border: _border(), enabledBorder: _border(),
                focusedBorder: _border(AppColors.primary),
                suffixIcon: _buildSuffix(),
                suffixIconConstraints: const BoxConstraints(
                    minWidth: 44, minHeight: AppDimens.fieldHeight),
              ),
            ),
          ),
          if (widget.errorText != null) ...[
            const SizedBox(height: 4),
            Text(widget.errorText!,
                style: AppTextStyles.termsText.copyWith(color: AppColors.errorText)),
          ],
        ],
      );
}
