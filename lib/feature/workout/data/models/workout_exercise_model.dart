import 'package:liftup/feature/workout/domain/entities/workout_exercise_entity.dart';

class WorkoutExerciseModel extends WorkoutExerciseEntity {
  final int? workoutExerciseId;
  final int workoutSessionId;
  final int exerciseId;
  final String? notes;

  WorkoutExerciseModel({
    this.workoutExerciseId,
    required this.exerciseId,
    required this.workoutSessionId,
    this.notes,
  }) : super(
    exerciseId: exerciseId, notes: notes,workoutExerciseId: workoutExerciseId,
  );

  Map<String, dynamic> toMap() {
    final map = {
      'we_ws_id': workoutSessionId,
      'we_exercise_id': exerciseId,
      'we_notes': notes,
    };
    if (workoutExerciseId != null) map['we_id'] = workoutExerciseId;
    return map;
  }

  factory WorkoutExerciseModel.fromMap(Map<String, dynamic> map) {
    return WorkoutExerciseModel(
      workoutExerciseId: map['we_id'],
      workoutSessionId: map['we_ws_id'],
      exerciseId: map['we_exercise_id'],
      notes: map['we_notes'],
    );
  }

}