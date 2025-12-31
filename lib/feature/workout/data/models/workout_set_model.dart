import 'package:liftup/feature/workout/domain/entities/workout_set_entity.dart';

class WorkoutSetModel extends WorkoutSetEntity {
  final int? workoutSetId;
  final int workoutExerciseId;
  final int setId;
  final double? actualWeight;
  final int? actualReps;
  final int? actualDistance;
  final int? actualDuration;

  WorkoutSetModel({
    this.workoutSetId,
    required this.setId,
    this.actualWeight,
    this.actualReps,
    this.actualDistance,
    this.actualDuration,
    required this.workoutExerciseId,
  }) : super (
    setId: setId, actualDistance: actualDistance, actualDuration: actualDuration,
    actualReps: actualReps, actualWeight: actualWeight, workoutSetId: workoutSetId,
  );

  Map<String, dynamic> toMap() {
    final map = {
      'wset_we_id': workoutExerciseId,
      'wset_actual_weight': actualWeight,
      'wset_actual_reps': actualReps,
      'wset_actual_duration': actualDuration,
      'wset_actual_distance': actualDistance,
    };
    if (workoutSetId != null) map['wset_id'] = workoutSetId;
    return map;
  }

  factory WorkoutSetModel.fromMap(Map<String, dynamic> map) {
    return WorkoutSetModel(
      workoutSetId: map['wset_id'],
      workoutExerciseId: map['wset_we_id'],
      actualWeight: map['wset_actual_weight'],
      actualReps: map['wset_actual_reps'],
      actualDuration: map['wset_actual_duration'],
      actualDistance: map['wset_actual_distance'], 
      setId: map['wset_rs_id'],
    );
  }
}