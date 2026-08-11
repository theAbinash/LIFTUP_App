import 'package:flutter/material.dart';
import 'package:liftup/core/widgets/app_section_divider.dart';
import 'package:liftup/core/widgets/input_text_field/app_inline_notes_field.dart';
import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';
import 'package:liftup/feature/workout/presentation/controllers/exercise_set_controller_manager.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/exercise_table_layout.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/rest_timer_button.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_table/workout/workout_exercise_table.dart';

class WorkoutExerciseBody extends StatelessWidget {
  
  final RoutineExerciseEntity exercise;
  final ExerciseSetControllerManager controllerManager;
  final ValueChanged<String>? onNotesChanged;
  final VoidCallback onRestTimerTap;
  final VoidCallback? onAddSet;

  const WorkoutExerciseBody({
    super.key,
    required this.exercise,
    required this.controllerManager,
    this.onNotesChanged,
    required this.onRestTimerTap,
    this.onAddSet,
  });

  @override
  Widget build(BuildContext context) {

    final layout = ExerciseTableLayout.forExerciseType(
      exercise.exerciseType,
      session: true,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppInlineNotesField(
          initialValue: exercise.exerciseNote,
          hintText: "Add notes...",
          onChanged: onNotesChanged,
        ),

        const AppSectionDivider(),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: RestTimerButton(
            enabled: exercise.restTimerEnabled,
            seconds: exercise.exerciseRestTime,
            onTap: onRestTimerTap,
          ),
        ),

        const AppSectionDivider(),

        WorkoutExerciseTable(
          layout: layout,
          sets: exercise.setValueList,
          controllerManager: controllerManager,
          onAddSet: onAddSet,
        ),
      ],
    );
  }
}