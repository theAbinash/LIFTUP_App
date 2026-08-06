import 'package:flutter/material.dart';
import 'package:liftup/feature/workout/domain/entities/routine_set_entity.dart';
import 'package:liftup/feature/workout/presentation/controllers/exercise_set_controller_manager.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise/exercise_table_layout.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_table/comman/add_set_button.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_table/comman/exercise_table_header.dart';
import 'package:liftup/feature/workout/presentation/widgets/exercise_table/workout/workout_set_row.dart';

class WorkoutExerciseTable extends StatelessWidget {

  final ExerciseTableLayout layout;
  final List<RoutineSetEntity> sets;
  final ExerciseSetControllerManager controllerManager;
  final VoidCallback? onAddSet;

  const WorkoutExerciseTable({
    super.key,
    required this.layout,
    required this.sets,
    required this.controllerManager,
    this.onAddSet,
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
          itemBuilder: (_, index) {

            final set = sets[index];

            return WorkoutSetRow(
              layout: layout,
              isEven: index.isEven,
              controller: controllerManager.controllerFor(set),
              setNumber: set.setCount,
              previousWeight: set.prevSetWeight,
              previousReps: set.prevRepsCount,
              previousDistance: set.prevSetDistance,
              previousDuration: set.prevSetDuration,

              isCompleted: set.isCompleted,

              onWeightChanged: (value) {
                set.setWeight = double.tryParse(value);
              },
              onRepsChanged: (value) {
                set.setRepsCount = int.tryParse(value);
              },
              onDistanceChanged: (value) {
                set.setDistance = int.tryParse(value);
              },
              onDurationChanged: (value) {
                set.setDuration = int.tryParse(value);
              },
              onCompleted: (completed) {
                set.isCompleted = completed;
              },
            );
          },
        ),

        AddSetButton(
          onPressed: onAddSet,
        ),
      ],
    );
  }
}