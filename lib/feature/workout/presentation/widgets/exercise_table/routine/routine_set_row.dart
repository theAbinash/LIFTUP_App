import 'package:flutter/material.dart';
import 'package:liftup/feature/workout/domain/entities/routine_set_entity.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/exercise_table_layout.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_table/comman/exercise_table_row.dart';

class RoutineSetRow extends StatelessWidget {
  final RoutineSetEntity set;
  final bool isEven;
  final ExerciseTableLayout layout;

  const RoutineSetRow({
    super.key,
    required this.set,
    required this.layout,
    this.isEven = false
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ExerciseTableRow(
      layout: layout,
      isEven: isEven,
      builder: (type) {
        switch (type) {
          case ExerciseColumnType.set:
            return Text(
              set.setCount.toString(),
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            );
          case ExerciseColumnType.weight:
            return Text(set.setWeight?.toStringAsFixed(1) ?? "-", style: theme.textTheme.bodyMedium);
          case ExerciseColumnType.reps:
            return Text(set.setRepsCount?.toString() ?? "-", style: theme.textTheme.bodyMedium);
          default:
            return const SizedBox.shrink();
        }
      },
    );
  }
    
}
