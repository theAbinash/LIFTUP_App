import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInlineNotesField extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final String hintText;
  final EdgeInsetsGeometry? padding;

  const AppInlineNotesField({
    super.key,
    this.initialValue,
    this.onChanged,
    this.hintText = "Add notes...",
    this.padding,
  });

  @override
  State<AppInlineNotesField> createState() => _AppInlineNotesFieldState();
}

class _AppInlineNotesFieldState extends State<AppInlineNotesField>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(
      text: widget.initialValue ?? "",
    );

    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() => _isEditing = false);
        widget.onChanged?.call(_controller.text.trim());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _startEditing() {
    if (_isEditing) return;

    setState(() => _isEditing = true);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: _startEditing,
      child: Padding(
        padding: widget.padding ??
            EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: _isEditing
              ? TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  autofocus: true,
                  minLines: 1,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isCollapsed: true,
                    hintText: "Add notes...",
                  ),
                  onChanged: widget.onChanged,
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /* Icon(
                      Icons.edit_note_outlined,
                      size: 20.sp,
                      color: theme.disabledColor,
                    ),
                    SizedBox(width: 10.w), */
                    Expanded(
                      child: Text(
                        _controller.text.isEmpty
                            ? widget.hintText
                            : _controller.text,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: _controller.text.isEmpty
                              ? theme.disabledColor
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}