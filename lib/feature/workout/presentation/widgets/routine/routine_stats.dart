import 'package:flutter/material.dart';
import 'package:liftup/feature/workout/domain/entities/routine_entity.dart';
import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';
import 'package:muscle_selector/muscle_selector.dart';

class RoutineStats extends StatelessWidget {
  final RoutineEntity routine;

  const RoutineStats({super.key, required this.routine});

  List<String> _getMappedMuscleGroups(
    List<RoutineExerciseEntity>? workoutList,
  ) {
    if (workoutList == null) return [];

    final Set<String> targetGroups = {};
    for (var exercise in workoutList) {
      for (var part in exercise.exerciseBodyParts) {
        switch (part.toUpperCase()) {
          case 'BICEPS':
            targetGroups.add('biceps');
            break;
          case 'TRICEPS':
            targetGroups.add('triceps');
            break;
          case 'CHEST':
            targetGroups.add('chest');
            break;
          case 'SHOULDERS':
            targetGroups.add('shoulders');
            break;
          case 'BACK':
            targetGroups.addAll([
              'lats',
              'upper_back',
              'lower_back',
              'trapezius',
            ]);
            break;
          case 'LATS':
            targetGroups.add('lats');
            break;
          case 'ABS':
          case 'CORE':
            targetGroups.addAll(['abs', 'obliques']);
            break;
          case 'LEGS':
            targetGroups.addAll(['quads', 'harmstrings', 'calves', 'glutes']);
            break;
          case 'QUADS':
            targetGroups.add('quads');
            break;
          case 'HAMSTRINGS':
            targetGroups.add('harmstrings');
            break;
          case 'CALVES':
            targetGroups.add('calves');
            break;
          case 'GLUTES':
            targetGroups.add('glutes');
            break;
          case 'FOREARMS':
            targetGroups.add('forearm');
            break;
          case 'NECK':
            targetGroups.add('neck');
            break;
          case 'TRAPS':
            targetGroups.add('trapezius');
            break;
        }
      }
    }
    return targetGroups.toList();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: _StatItem(
              value: "${routine.estimatedDuration}",
              unit: "min",
              label: "Duration",
            ),
          ),

          const VerticalDivider(
            thickness: 0.4,
            color: Color.fromARGB(255, 187, 186, 186),
          ),

          Expanded(
            child: _StatItem(
              value: "${routine.workoutList?.length ?? 0}",
              label: "Exercises",
            ),
          ),

          const VerticalDivider(
            thickness: 0.4,
            color: Color.fromARGB(255, 187, 186, 186),
          ),

          Expanded(
            child: _StatItem(
              value: "${routine.estimatedDuration}",
              label: "Sets",
            ),
          ),

          const VerticalDivider(
            thickness: 0.4,
            color: Color.fromARGB(255, 187, 186, 186),
          ),

          Expanded(
            child: Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: AbsorbPointer(
                  child: MusclePickerMap(
                    map: Maps.BODY,
                    onChanged: (muscles) {},
                    isEditing:
                        true, // true makes it unselectable based on package logic
                    selectedColor: Colors.blue,
                    initialSelectedGroups: _getMappedMuscleGroups(
                      routine.workoutList,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final String? unit;

  const _StatItem({required this.value, required this.label, this.unit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            children: [
              TextSpan(text: value),
              if (unit != null)
                TextSpan(
                  text: " $unit",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
            ],
          ),
        ),

        const SizedBox(height: 4),

        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
