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
      case ExerciseColumnType.spacer:
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
          for (int i = 0; i < layout.columns.length; i++) ...[
            ExerciseColumn(
              width: layout.columns[i].width,
              flex: layout.columns[i].flex,
              alignment: Alignment.centerLeft,
              child: layout.columns[i].type == ExerciseColumnType.completed
                  ? Icon(Icons.check, size: 18, color: Colors.grey[600])
                  : Padding(
                      padding: EdgeInsets.only(
                        left: [
                          ExerciseColumnType.weight,
                          ExerciseColumnType.reps,
                          ExerciseColumnType.distance,
                          ExerciseColumnType.duration,
                        ].contains(layout.columns[i].type)
                            ? 10.w
                            : 0,
                      ),
                      child: Text(_label(layout.columns[i].type), style: style),
                    ),
            ),
          if (i != layout.columns.length - 1) SizedBox(width: 12.w),
          ],
        ],
      ),
    );
  }
}