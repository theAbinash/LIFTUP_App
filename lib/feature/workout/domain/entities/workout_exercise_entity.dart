import 'package:liftup/feature/workout/domain/entities/workout_set_entity.dart';

class WorkoutExerciseEntity {
  final int? workoutExerciseId;
  final int exerciseId;
  final String? notes;
  final List<WorkoutSetEntity> setList;

  WorkoutExerciseEntity({
    this.workoutExerciseId,
    required this.exerciseId,
    this.notes,
    this.setList = const [],
  });
}