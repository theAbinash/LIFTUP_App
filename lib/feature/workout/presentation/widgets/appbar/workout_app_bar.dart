import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkoutAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final VoidCallback onClose;
  final VoidCallback onFinish;

  const WorkoutAppBar({
    super.key,
    required this.title,
    required this.onClose,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      elevation: 0,
      centerTitle: true,

      leadingWidth: 56,

      leading: IconButton(
        splashRadius: 22.r,
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 32.sp,
        ),
        onPressed: onClose,
      ),

      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),

      actions: [

        Padding(
          padding: EdgeInsets.only(right: 12.w),

          child: SizedBox(
            height: 36.h,
            child: FilledButton(
              onPressed: onFinish,

              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.r),
                ),
              ),

              child: Text(
                "Finish",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}