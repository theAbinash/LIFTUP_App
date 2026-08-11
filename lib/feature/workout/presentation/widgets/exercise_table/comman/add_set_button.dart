import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/core/theme/theme_extensions.dart';

class AddSetButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const AddSetButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        top: 8.h,
        left: 16.w,
        right: 16.w,
        bottom: 8.h,
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.add),
        label: const Text("Add Set"),
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(44.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          backgroundColor: context.theme.dividerColor,
          foregroundColor: Colors.black,
        ),
      )
    );
  }
}