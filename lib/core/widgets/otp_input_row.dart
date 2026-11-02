import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/app_dimens.dart';
import 'otp_box.dart';

/// Reusable row of single-digit boxes with auto-advance and paste support.
class OtpInputRow extends StatefulWidget {
  const OtpInputRow({
    super.key, this.length = 6, required this.onChanged,
    this.hasError = false, this.code, this.autoFocus = true,
  });

  final int length;
  final ValueChanged<String> onChanged;
  final bool hasError, autoFocus;
  final String? code;

  @override
  State<OtpInputRow> createState() => _OtpInputRowState();
}

class _OtpInputRowState extends State<OtpInputRow> {
  late final List<TextEditingController> _ctrls;
  late final List<FocusNode> _nodes;

  String get _current => _ctrls.map((c) => c.text).join();

  @override
  void initState() {
    super.initState();
    _ctrls = List.generate(widget.length, (_) => TextEditingController());
    _nodes = List.generate(widget.length, (idx) => FocusNode()
      ..addListener(() => setState(() {}))
      ..onKeyEvent = (_, evt) {
        if (evt is KeyDownEvent && evt.logicalKey == LogicalKeyboardKey.backspace && _ctrls[idx].text.isEmpty && idx > 0) {
          _nodes[idx - 1].requestFocus();
          _ctrls[idx - 1].clear();
          widget.onChanged(_current);
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      });
    _syncCode(widget.code);
    if (widget.autoFocus && _nodes.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) => mounted ? _nodes.first.requestFocus() : null);
    }
  }

  @override
  void didUpdateWidget(OtpInputRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.code != oldWidget.code && widget.code != _current) {
      _syncCode(widget.code);
      if ((widget.code?.isEmpty ?? true) && _nodes.isNotEmpty) _nodes.first.requestFocus();
    }
  }

  void _syncCode(String? code) {
    final clean = (code ?? '').replaceAll(RegExp(r'\D'), '');
    for (int i = 0; i < widget.length; i++) { _ctrls[i].text = i < clean.length ? clean[i] : ''; }
  }

  void _handleChanged(int idx, String val) {
    final digits = val.replaceAll(RegExp(r'\D'), '');
    if (digits.length > 1) {
      for (int i = 0; i < widget.length && i < digits.length; i++) { _ctrls[i].text = digits[i]; }
      final next = digits.length < widget.length ? digits.length : widget.length - 1;
      _nodes[next].requestFocus();
    } else {
      _ctrls[idx].text = digits;
      if (digits.isNotEmpty && idx < widget.length - 1) _nodes[idx + 1].requestFocus();
    }
    widget.onChanged(_current);
  }

  @override
  void dispose() {
    for (final c in _ctrls) { c.dispose(); }
    for (final n in _nodes) { n.dispose(); }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: (_, c) {
        final maxW = c.maxWidth.isFinite ? c.maxWidth : 360.0;
        final n = widget.length;
        final gap = maxW < 280 ? 4.0 : (maxW < 320 ? 6.0 : (maxW < 350 ? 8.0 : AppDimens.otpBoxGap));
        final size = ((maxW - (n - 1) * gap) / n).floorToDouble().clamp(30.0, AppDimens.otpBoxSize);
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(n, (i) => OtpBox(
            controller: _ctrls[i], focusNode: _nodes[i], hasError: widget.hasError,
            isLast: i == n - 1, size: size, gap: gap, onChanged: (val) => _handleChanged(i, val),
          )),
        );
      });
}
