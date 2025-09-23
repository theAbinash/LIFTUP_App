import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewRoutineCard extends StatelessWidget {
  final VoidCallback onTap;

  const NewRoutineCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // action when tapped
      borderRadius: BorderRadius.circular(15.r),
      child: Container(
        width: 150.w,
        height: 80.h,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.grey[850], // dark grey background
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/notes_icon.png",
              width: 20.w,
            ),
            SizedBox(height: 9.h),
            Text(
              "New Routine",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
