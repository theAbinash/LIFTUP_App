import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkoutSummarySection extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback? onTap;

  const WorkoutSummarySection({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget child = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
            icon,
            size: 20.sp,
            color: theme.colorScheme.primary,
          ),

          SizedBox(height: 6.h),

          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 2.h),

          Text(
            title,
            style: theme.textTheme.labelSmall,
          ),
      ],
    );

    if (onTap == null) {
      return child;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: child,
    );

  }
}