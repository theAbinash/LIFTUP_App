import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCheckButton extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const AppCheckButton({
    super.key,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(30.r),
      onTap: () => onChanged?.call(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: value
              ? theme.colorScheme.primary
              : Colors.transparent,
          border: Border.all(
            width: 2,
            color: value
                ? theme.colorScheme.primary
                : theme.dividerColor,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 180),
          child: value
              ? const Icon(
                  Icons.check,
                  key: ValueKey(true),
                  size: 16,
                  color: Colors.white,
                )
              : const SizedBox(
                  key: ValueKey(false),
                ),
        ),
      ),
    );
  }
}