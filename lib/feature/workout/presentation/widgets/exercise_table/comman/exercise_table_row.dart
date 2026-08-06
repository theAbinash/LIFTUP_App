import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/exercise_table_layout.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_table/comman/exercise_column.dart';

class ExerciseTableRow extends StatelessWidget {
  final ExerciseTableLayout layout;
  final bool isEven;
  final Widget Function(ExerciseColumnType type) builder;

  const ExerciseTableRow({
    super.key,
    required this.layout,
    required this.builder,
    this.isEven = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isEven ? Colors.transparent : Colors.grey.withOpacity(0.06),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (final col in layout.columns) ...[
            ExerciseColumn(width: col.width, child: builder(col.type)),
            SizedBox(width: 16.w),
          ],
        ],
      ),
      /* child: Row(
        children: layout.columns.map((col) {
          //final isSet = col.type == ExerciseColumnType.set;
          return ExerciseColumn(
            flex: col.flex,
            alignment: Alignment.centerLeft,
            child: builder(col.type),
          );
        }).toList(),
      ), */
    );
  }
}