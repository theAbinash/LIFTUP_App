import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BodyOverviewPlaceholder extends StatelessWidget {
  const BodyOverviewPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 100.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Icon(
                Icons.accessibility_new,
                size: 26.sp,
                color: theme.disabledColor,
              ),

              SizedBox(width: 8.w),

              Icon(
                Icons.accessibility_new,
                size: 26.sp,
                color: theme.disabledColor,
              ),

            ],
          ),

          SizedBox(height: 6.h),

          Text(
            "Body",
            style: theme.textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}