import 'package:liftup/feature/workout/domain/entities/routine_set_entity.dart';
import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';

class RoutineExerciseModel extends RoutineExerciseEntity {

  final int exerciseId;
  final int? workoutId;
  final String? exerciseName;
  final String? exerciseImageUrl;
  final int? routineID;
  final String? routineName;
  final String? exerciseNote;
  final int? exerciseRestTime;
  final int exerciseType;
  final List<RoutineSetEntity> setValueList;
  final bool restTimerEnabled;
  
  RoutineExerciseModel({
    required this.exerciseId,
    this.workoutId,
    this.exerciseName,
    this.exerciseImageUrl,
    this.routineID,
    this.routineName,
    required this.setValueList, 
    this.exerciseNote,
    required this.exerciseType,
    this.exerciseRestTime,
    this.restTimerEnabled = false,
  }) : super(
    exerciseId: exerciseId, exerciseName: exerciseName,
    exerciseImageUrl: exerciseImageUrl, routineID: routineID,
    routineName: routineName, setValueList: setValueList, exerciseType: exerciseType,
    workoutId: workoutId, exerciseNote: exerciseNote, exerciseRestTime: exerciseRestTime, 
    restTimerEnabled: restTimerEnabled
  );

  Map<String, dynamic> toMap() {
    final map = {
      'rd_rh_id': routineID,
      'rd_exercise_id': exerciseId,
      'rd_rest_timer': exerciseRestTime,
      'rd_notes': exerciseNote,
      'rd_rest_timer_on': restTimerEnabled ? 1 : 0,
      'rd_exercise_type_id': exerciseType,
    };

    if(workoutId != 0) {
      map['rd_id'] = workoutId;
    }
    return map;
  }

  factory RoutineExerciseModel.fromMap(Map<String, dynamic> map) {
    return RoutineExerciseModel(
      workoutId: map['rd_id'] ?? 0,
      routineID: map['rd_rh_id'] ?? '',
      exerciseId: map['rd_exercise_id'] ?? 0,
      exerciseRestTime: map['rd_rest_timer'] ?? 0,
      restTimerEnabled: (map['rd_rest_timer_on'] ?? 0) == 1,
      exerciseNote: map['rd_notes'] ?? '', 
      exerciseType: map['exercise_type_id'],
      setValueList: [],  

      );
  }

}