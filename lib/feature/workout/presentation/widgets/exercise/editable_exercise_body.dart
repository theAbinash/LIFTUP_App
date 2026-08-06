import 'package:flutter/material.dart';
import 'package:liftup/core/widgets/app_section_divider.dart';
import 'package:liftup/core/widgets/input_text_field/app_inline_notes_field.dart';
import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/exercise_table_layout.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/rest_timer_button.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/rest_timer_picker.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_table/editable/editable_exercise_table.dart';

class EditableExerciseBody extends StatelessWidget {
  
  final RoutineExerciseEntity exercise;
  final ValueChanged<String>? onNotesChanged;
  final VoidCallback? onAddSet;
  final void Function(bool enabled, int? seconds)? onRestTimerChanged;

  const EditableExerciseBody({
    super.key,
    required this.exercise,
    this.onNotesChanged,
    this.onAddSet,
    this.onRestTimerChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        AppInlineNotesField(
          initialValue: exercise.exerciseNote,
          hintText: "Exercise notes...",
          onChanged: onNotesChanged,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: RestTimerButton(
            enabled: exercise.restTimerEnabled,
            seconds: exercise.exerciseRestTime, 
            onTap: () {
              RestTimerPicker.show(
                context,  
                currentEnabled: exercise.restTimerEnabled,
                currentSeconds: exercise.exerciseRestTime,
                onChanged: (enabled, seconds) {
                  onRestTimerChanged?.call(enabled, seconds);
                },
              );
            }
          ),
        ),

        const AppSectionDivider(),

        EditableExerciseTable(
          //layout: layout,
          exercise: exercise,
          sets: exercise.setValueList,
          onAddSet: onAddSet,
        ),
      ],
    );
  }
}