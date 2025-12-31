import 'package:liftup/feature/workout/domain/entities/routine_entity.dart';
import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';

class RoutineModel extends RoutineEntity {

  final int routineId;
  final String routineName;
  final int? routineCreatedPersonId;
  final String? createdPersonName;
  final int? routineScope;
  final DateTime? routineCreatedDate;
  final List<RoutineExerciseEntity>? workoutList;

  RoutineModel({
    required this.routineId,
    required this.routineName,
    this.routineCreatedPersonId,
    this.createdPersonName,
    this.routineScope,
    this.routineCreatedDate,
    this.workoutList,
  }) : super(
    routineId: routineId, routineCreatedDate: routineCreatedDate,
    routineCreatedPersonId: routineCreatedPersonId, workoutList: workoutList,
    routineName: routineName, routineScope: routineScope,
  );

  Map<String, dynamic> toMap() {
    final map = {
      'rh_name': routineName,
      'rh_created_person_id': routineCreatedPersonId,
      'rh_scope': routineScope,
      'rh_create_date': routineCreatedDate?.toIso8601String(),
    };

    if (routineId != 0) {
      map['rh_id'] = routineId;
    }

    return map;

  }

  factory RoutineModel.fromMap(Map<String, dynamic> map) {
    return RoutineModel(
      routineId: map['rh_id'] ?? 0,
      routineName: map['rh_name'] ?? '',
      routineCreatedPersonId: map['rh_created_person_id'] ?? 0,
      routineScope: map['rh_scope'] ?? 0,
      routineCreatedDate: map['rh_create_date'] != null && map['rh_create_date'] != ''
        ? DateTime.parse(map['rh_create_date'])
        : null,
      workoutList: []
      );
  }

}