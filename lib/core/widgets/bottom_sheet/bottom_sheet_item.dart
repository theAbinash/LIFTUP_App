import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSheetItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final Color? titleColor;
  final VoidCallback onTap;

  const BottomSheetItem({
    super.key,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.leading,
    this.trailing,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
          child: Row(
            children: [

              if (leading != null) ...[
                leading!,
                SizedBox(width: 16.w),
              ],

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge,
                    ),

                    if (subtitle != null) ...[
                      SizedBox(height: 2.h),

                      Text(
                        subtitle!,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium,
                      ),
                    ],
                  ],
                ),
              ),

              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}