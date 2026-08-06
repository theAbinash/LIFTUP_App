import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExerciseImage extends StatelessWidget {
  final String imageUrl;

  const ExerciseImage({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Image.network(
        imageUrl,
        width: 54.w,
        height: 54.w,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return Container(
            width: 54.w,
            height: 54.w,
            color: Theme.of(context).dividerColor,
            child: const Icon(Icons.image_not_supported),
          );
        },
      ),
    );
  }
}