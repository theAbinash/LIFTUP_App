import 'package:flutter/material.dart';
import 'package:liftup/core/widgets/buttons/app_check_button.dart';
import 'package:liftup/core/widgets/input_text_field/app_input_field.dart';
import 'package:liftup/feature/workout/presentation/controllers/exercise_set_controller.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/exercise_table_layout.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_table/comman/exercise_previous_value.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_table/comman/exercise_table_row.dart';

class WorkoutSetRow extends StatelessWidget {
  final ExerciseSetController controller;
  final int setNumber;
  final ExerciseTableLayout layout;

  final double? previousWeight;
  final int? previousReps;
  final int? previousDistance;
  final int? previousDuration;

  final bool isCompleted;
  final bool isEven;

  final ValueChanged<String>? onWeightChanged;
  final ValueChanged<String>? onRepsChanged;
  final ValueChanged<String>? onDistanceChanged;
  final ValueChanged<String>? onDurationChanged;
  final ValueChanged<bool>? onCompleted;

  const WorkoutSetRow({
    super.key,
    required this.controller,
    required this.setNumber,
    required this.isCompleted,
    required this.layout,
    this.isEven = false,
    this.previousWeight,
    this.previousReps,
    this.previousDistance,
    this.previousDuration,
    this.onWeightChanged,
    this.onRepsChanged,
    this.onDistanceChanged,
    this.onDurationChanged,
    this.onCompleted,
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
          case ExerciseColumnType.previous:
            return ExercisePreviousValue(
              weight: previousWeight,
              reps: previousReps,
              distance: previousDistance,
              duration: previousDuration,
            );
          case ExerciseColumnType.weight:
            return AppInputField(
              controller: controller.weightController,
              focusNode: controller.weightFocusNode,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: onWeightChanged,
              showBorder: false,
            );
          case ExerciseColumnType.reps:
            return AppInputField(
              controller: controller.repsController,
              focusNode: controller.repsFocusNode,
              keyboardType: TextInputType.number,
              onChanged: onRepsChanged,
              showBorder: false,
            );
          case ExerciseColumnType.distance:
            return AppInputField(
              controller: controller.distanceController,
              focusNode: controller.distanceFocusNode,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: onDistanceChanged,
              showBorder: false,
            );
          case ExerciseColumnType.duration:
            return AppInputField(
              controller: controller.durationController,
              focusNode: controller.durationFocusNode,
              keyboardType: TextInputType.number,
              onChanged: onDurationChanged,
              showBorder: false,
            );
          case ExerciseColumnType.completed:
            return AppCheckButton(value: isCompleted, onChanged: onCompleted);
          default:
            return const SizedBox.shrink();
        }
      }
    );

  }
}