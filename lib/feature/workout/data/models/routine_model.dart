import 'dart:ffi';

import 'package:gym_log/feature/workout/domain/entities/routine_entity.dart';

class RoutineModel extends RoutineEntity {

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

  RoutineModel({
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
  }) : super(
    routineId: routineId, routineCreatedDate: routineCreatedDate,
    exerciseRestTimer: exerciseRestTimer, routineCreatedPersonId: routineCreatedPersonId,
    routineDetailId: routineDetailId, routineExerciseId: routineExerciseId, 
    routineName: routineName, routineScope: routineScope, setCountValue: setCountValue,
    setDistanceValue: setDistanceValue, setDurationValue: setDurationValue, setId: setId,
    setRepsCountValue: setRepsCountValue, setWeightValue: setWeightValue,
  );

  Map<String, dynamic> toMap() {
    return {
      'rh_id': routineId,
      'rh_name': routineName,
      'rh_created_person_id': routineCreatedPersonId,
      'rh_scope': routineScope,
      'rh_create_date': routineCreatedDate,
    };
  }

  factory RoutineModel.fromMap(Map<String, dynamic> map) {
    return RoutineModel(
      routineId: map['rh_id'] ?? 0,
      routineName: map['rh_name'] ?? '',
      routineCreatedPersonId: map['rh_created_person_id'] ?? 0,
      routineScope: map['rh_scope'] ?? 0,
      routineCreatedDate: map['rh_create_date'] ?? ''
      );
  }

}