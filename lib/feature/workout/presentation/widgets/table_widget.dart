import 'package:flutter/material.dart';
import 'package:liftup/feature/workout/domain/entities/exercise_column_entity.dart';
import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';
import 'package:liftup/feature/workout/presentation/widgets/table_header_row.dart';
import 'package:liftup/feature/workout/presentation/widgets/table_value_row.dart';

class TableWidget extends StatelessWidget {
  final List<ExerciseColumnEntity> columns;
  final RoutineExerciseEntity exercises;
  final ThemeData theme;
  final void Function(int index)? onSetComplete;

  const TableWidget({
    super.key, 
    required this.columns,
    required this.exercises,
    required this.theme,
    this.onSetComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TableHeaderRow(columns: columns, theme: theme,),
        //SizedBox(height: 4.h,),
        ...List.generate(
            exercises.setValueList.length, 
            (index) => TableValueRow(
              columns: columns, 
              set: exercises.setValueList[index], 
              theme: theme,
              onComplete: () => onSetComplete?.call(index),
            )
          )
      ],
    );
  }
}