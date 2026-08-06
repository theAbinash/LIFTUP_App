import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liftup/feature/workout/domain/entities/routine_set_entity.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/exercise_table_layout.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_table/comman/exercise_table_header.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_table/routine/routine_set_row.dart';

class RoutineExerciseTable extends StatelessWidget {
  final List<RoutineSetEntity> sets;
  final ExerciseTableLayout layout;

  const RoutineExerciseTable({
    super.key,
    required this.sets,
    required this.layout,
  });

  @override
  Widget build(BuildContext context) {  

    return Column(
      children: [

        ExerciseTableHeader(layout: layout),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sets.length,
          itemBuilder: (_, index) => RoutineSetRow(
            set: sets[index],
            layout: layout,
            isEven: index.isEven,
            )
        ),

        SizedBox(height: 6.h),
      ],
    );
  }
}