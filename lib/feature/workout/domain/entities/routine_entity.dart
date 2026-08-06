import 'package:liftup/core/utils/constants.dart';
import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';

class RoutineEntity {
  final int routineId;
  final String routineName;
  final int? routineCreatedPersonId;
  final String? createdPersonName;
  final int? routineScope;
  final DateTime? routineCreatedDate;
  final List<RoutineExerciseEntity>? workoutList;

  const RoutineEntity({
    required this.routineId,
    required this.routineName,
    this.routineCreatedPersonId,
    this.createdPersonName,
    this.routineScope,
    this.routineCreatedDate,
    this.workoutList,
  });

  /* int get totalSets {
    int total = 0;
    for (final exercise in workoutList ?? []) {
      total += exercise.setValueList.length;
    }
    return total;
  } */

  int get estimatedDuration {
    int totalSets = 0;
    for (var exercise in workoutList!) {
      totalSets += exercise.setValueList.length;
    }
    return totalSets; 
  }


}