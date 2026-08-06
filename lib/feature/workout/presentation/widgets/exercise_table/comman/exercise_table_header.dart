import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/exercise_table_layout.dart';

import 'exercise_column.dart';

class ExerciseTableHeader extends StatelessWidget {

  final ExerciseTableLayout layout;

  const ExerciseTableHeader({
    super.key,
    required this.layout,
  });

  String _label(ExerciseColumnType type) {
    switch (type) {
      case ExerciseColumnType.set:
        return "SET";
      case ExerciseColumnType.previous:
        return "PREVIOUS";
      case ExerciseColumnType.weight:
        return "KG";
      case ExerciseColumnType.reps:
        return "REPS";
      case ExerciseColumnType.distance:
        return "KM";
      case ExerciseColumnType.duration:
        return "TIME";
      case ExerciseColumnType.completed:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: .5,
          color: Colors.grey,
        );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (final col in layout.columns) ...[
            ExerciseColumn(
              width: col.width,
              child: col.type == ExerciseColumnType.completed
                  ? Icon(Icons.check, size: 18, color: Colors.grey[600])
                  : Text(_label(col.type), style: style),
            ),
            SizedBox(width: 16.w),
          ],
        ],
      ),
    );
  }
}