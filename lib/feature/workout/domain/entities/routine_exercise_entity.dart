import 'package:liftup/feature/workout/domain/entities/routine_set_entity.dart';

class RoutineExerciseEntity {
  final int? workoutId;
  final int exerciseId;
  final String? exerciseName;
  final String? exerciseImageUrl;
  final int? routineID;
  final String? routineName;

  String? exerciseNote;
  int? exerciseRestTime;

  final int? exerciseSeqNo;
  final int exerciseType;
  final List<String> exerciseBodyParts;
  final List<String> exerciseEquipments;
  final List<RoutineSetEntity> setValueList;

  RoutineExerciseEntity({
    required this.exerciseId,
    this.exerciseName,
    this.exerciseImageUrl,
    this.routineID,
    this.routineName,
    this.exerciseSeqNo,
    required this.exerciseType,
    this.setValueList = const [],
    this.workoutId,
    this.exerciseNote,
    this.exerciseRestTime,
    this.exerciseBodyParts = const [],
    this.exerciseEquipments = const [],
  });
}