import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInputField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;

  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;

  final String? hintText;
  final String? suffixText;
  final String? prefixText;

  final bool enabled;
  final bool autofocus;
  final bool autoSelectOnFocus;
  final bool readOnly;

  final TextAlign textAlign;
  final TextInputType keyboardType;

  final List<TextInputFormatter>? inputFormatters;

  final double? width;
  final double height;

  final int minLines;
  final int? maxLines;
  final bool showBorder;

  const AppInputField({
    super.key,
    required this.controller,
    this.focusNode,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.hintText,
    this.suffixText,
    this.prefixText,
    this.enabled = true,
    this.autofocus = false,
    this.autoSelectOnFocus = true,
    this.readOnly = false,
    this.textAlign = TextAlign.left,
    this.keyboardType = const TextInputType.numberWithOptions(decimal: true),
    this.inputFormatters,
    this.width,
    this.height = 42,
    this.minLines = 1,
    this.maxLines = 1,
    this.showBorder = true,
  });

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  late final FocusNode _internalFocusNode;

  FocusNode get _focusNode => widget.focusNode ?? _internalFocusNode;

  @override
  void initState() {
    super.initState();

    _internalFocusNode = FocusNode();

    _focusNode.addListener(_handleFocusChanged);
  }

  void _handleFocusChanged() {
    if (_focusNode.hasFocus && widget.autoSelectOnFocus) {
      widget.controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: widget.controller.text.length,
      );
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChanged);

    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: widget.width?.w,
      height: widget.maxLines == 1 ? widget.height.h : null,
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        enabled: widget.enabled,
        autofocus: widget.autofocus,
        readOnly: widget.readOnly,
        textAlign: widget.textAlign,
        keyboardType: widget.keyboardType,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        onEditingComplete: widget.onEditingComplete,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 8.h,
          ),
          hintText: widget.hintText,
          prefixText: widget.prefixText,
          suffixText: widget.suffixText,
          border: widget.showBorder ? null : InputBorder.none,
          enabledBorder: widget.showBorder ? null : InputBorder.none,
          focusedBorder: widget.showBorder
            ? null
            : const UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 1.5)),
        ),
      ),
    );
  }
}