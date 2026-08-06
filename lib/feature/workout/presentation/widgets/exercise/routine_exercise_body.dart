import 'package:flutter/material.dart';
import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/exercise_table_layout.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_table/routine/routine_exercise_table.dart';

class RoutineExerciseBody extends StatelessWidget {
  final RoutineExerciseEntity exercise;

  const RoutineExerciseBody({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    final layout = ExerciseTableLayout.forExerciseType(
      exercise.exerciseType,
      session: false
    );

    return RoutineExerciseTable(
      sets: exercise.setValueList,
      layout: layout,
    );
  }
}