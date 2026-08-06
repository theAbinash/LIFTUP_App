import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/exercise_info.dart';

class ExerciseHeader extends StatelessWidget {
  final String title;
  final String imageUrl;

  final List<String> bodyParts;
  final List<String> equipments;

  final VoidCallback onToggleExpand;
  final Widget? trailing;

  const ExerciseHeader({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.bodyParts,
    required this.equipments,
    required this.onToggleExpand,
    this.trailing
  });

 @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onToggleExpand,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              /// Exercise Image
              ClipOval(
                child: Image.network(
                  imageUrl,
                  width: 44.w,
                  height: 44.w,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).dividerColor,
                      ),
                      child: const Icon(Icons.fitness_center, size: 20),
                    );
                  },
                ),
              ),

              SizedBox(width: 14.w),

              /// Exercise Info
              Expanded(
                child: ExerciseInfo(
                  title: title,
                  bodyParts: bodyParts,
                  equipments: equipments,
                ),
              ),

              /// Trailing Widget (Popup Menu by default)
              //trailing ?? const ExercisePopupMenu(),

            ],
          ),
        ),
      ),
    );
  }
}