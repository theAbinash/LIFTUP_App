import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  final Widget? leading;
  final Widget? trailing;

  const BottomSheetHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        if (leading != null) ...[
          leading!,
          SizedBox(width: 12.w),
        ],

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              if (subtitle != null) ...[
                SizedBox(height: 4.h),

                Text(
                  subtitle!,
                  style: theme.textTheme.labelMedium,
                ),
              ]
            ],
          ),
        ),

        if (trailing != null) trailing!,
      ],
    );
  }
}