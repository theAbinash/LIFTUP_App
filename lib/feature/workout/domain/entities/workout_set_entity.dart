class WorkoutSetEntity {
  final int? workoutSetId;
  final int setId;
  final double? actualWeight;
  final int? actualReps;
  final int? actualDistance;
  final int? actualDuration;

  WorkoutSetEntity({
    this.workoutSetId,
    required this.setId,
    this.actualWeight,
    this.actualReps,
    this.actualDistance,
    this.actualDuration
  });
  
}