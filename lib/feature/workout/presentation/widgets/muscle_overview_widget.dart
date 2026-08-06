import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MuscleOverviewWidget extends StatelessWidget {
  final String frontImage;
  final String backImage;

  const MuscleOverviewWidget({
    super.key,
    required this.frontImage,
    required this.backImage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        SvgPicture.asset(
          frontImage,
          height: 50.h,
        ),

        SizedBox(width: 6.w),

        SvgPicture.asset(
          backImage,
          height: 50.h,
        ),
      ],
    );
  }
}