import 'package:flutter/material.dart';
import 'package:liftup/core/widgets/input_text_field/app_input_field.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/exercise_table_layout.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_table/comman/exercise_table_row.dart';

class EditableSetRow extends StatelessWidget {
  final int setNumber;
  final ExerciseTableLayout layout;
  final bool isEven;

  final TextEditingController weightController;
  final TextEditingController repsController;
  final TextEditingController distanceController;
  final TextEditingController durationController;

  final ValueChanged<String>? onWeightChanged;
  final ValueChanged<String>? onRepsChanged;
  final ValueChanged<String>? onDistanceChanged;
  final ValueChanged<String>? onDurationChanged;

  const EditableSetRow({
    super.key,
    required this.setNumber,
    required this.weightController,
    required this.repsController,
    required this.distanceController, 
    required this.durationController,
    required this.layout,
    this.isEven = false,
    this.onWeightChanged,
    this.onRepsChanged, 
    this.onDistanceChanged,
    this.onDurationChanged,
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
              setNumber.toString(),
              style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            );
          case ExerciseColumnType.weight:
            return AppInputField(
              controller: weightController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: onWeightChanged,
            );
          case ExerciseColumnType.reps:
            return AppInputField(
              controller: repsController,
              keyboardType: TextInputType.number,
              onChanged: onRepsChanged,
            );
          default:
            return const SizedBox.shrink();
        }
      }
    );
  }
}