import 'package:liftup/feature/workout/domain/entities/routine_set_entity.dart';

class RoutineExerciseEntity {

  final int? workoutId;
  final int exerciseId;
  final String? exerciseName;
  final String? exerciseImageUrl;
  final int? routineID;
  final String? routineName;
  final String? exerciseNote;
  final int? exerciseRestTime;
  final int? exerciseSeqNo;
  final List<RoutineSetEntity> setValueList;

  const RoutineExerciseEntity({
    required this.exerciseId,
    this.exerciseName,
    this.exerciseImageUrl,
    this.routineID,
    this.routineName,
    this.exerciseSeqNo,
    this.setValueList = const [],
    this.workoutId, this.exerciseNote, this.exerciseRestTime
  });

}