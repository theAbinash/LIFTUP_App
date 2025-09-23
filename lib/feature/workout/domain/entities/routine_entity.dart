import 'dart:ffi';

class RoutineEntity {
  final int routineId;
  final String? routineName;
  final int? routineCreatedPersonId;
  final int? routineScope;
  final DateTime routineCreatedDate;
  final int? routineDetailId;
  final int? routineExerciseId;
  final int? exerciseRestTimer;
  final int? setId;
  final int? setCountValue;
  final Double? setWeightValue;
  final int? setRepsCountValue;
  final int? setDistanceValue;
  final int? setDurationValue;

  const RoutineEntity({
    required this.routineId,
    this.routineName,
    this.routineCreatedPersonId,
    this.routineScope,
    required this.routineCreatedDate,
    this.routineDetailId,
    this.routineExerciseId,
    this.exerciseRestTimer,
    this.setId,
    this.setCountValue,
    this.setWeightValue,
    this.setRepsCountValue,
    this.setDistanceValue,
    this.setDurationValue
  });

}