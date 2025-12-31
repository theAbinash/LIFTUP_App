import 'package:liftup/core/session/session_manager.dart';
import 'package:liftup/feature/workout/data/datasources/local/routine_local_data_source.dart';
import 'package:liftup/feature/workout/data/models/routine_model.dart';
import 'package:liftup/feature/workout/data/models/routine_exercise_model.dart';
import 'package:liftup/feature/workout/data/models/routine_set_model.dart';
import 'package:liftup/feature/workout/domain/entities/routine_entity.dart';
import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';
import 'package:liftup/feature/workout/domain/entities/routine_set_entity.dart';
import 'package:liftup/feature/workout/domain/entities/workout_session_entity.dart';
import 'package:liftup/feature/workout/domain/repositories/routine_repository.dart';

class RoutineRepositoryImpl implements RoutineRepository {

  final RoutineLocalDataSource localDataSource;

  RoutineRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<List<RoutineEntity>> getRoutineList({bool forceRefresh = false}) async {
    /* if(forceRefresh){
      final 
    } */

   final userId = await SessionManager.getUserId() ?? 0;

   final localdata = await localDataSource.getRoutineList(userId);

   final routineMap = <int, RoutineEntity>{};
   final exerciseMap = <int, RoutineExerciseEntity>{};

   for (final row in localdata) {

    final routineId = row['routine_id'] as int? ?? 0;
    final workoutId = row['workout_id'] as int? ?? 0;
    final setId = row['set_id'] as int? ?? 0;

    //Add Routine
    routineMap.putIfAbsent(routineId, () {
      return RoutineEntity(
        routineId: routineId,
        routineName: row['routine_name'] ?? '',
        routineCreatedPersonId: row['routine_created_person_id'],
        routineScope: row['routine_scope'],
        routineCreatedDate: row['routine_create_date'] != null && row['routine_create_date'] != ''
            ? DateTime.tryParse(row['routine_create_date'])
            : null,
        workoutList: [],
      );
    });

    //Add Exercise
    if (workoutId != 0 && !exerciseMap.containsKey(workoutId)) {
      final exercise = RoutineExerciseEntity(
        workoutId: workoutId,
        exerciseId: row['exercise_id'] ?? 0,
        exerciseName: row['exercise_name'],
        exerciseNote: row['exercise_note'],
        exerciseRestTime: row['exercise_rest_time'],
        routineID: routineId,
        setValueList: [],
      );

      exerciseMap[workoutId] = exercise;
      routineMap[routineId]?.workoutList?.add(exercise);
    }

    //Add Set
    if (setId != 0) {
      final setEntity = RoutineSetEntity(
        setId: setId,
        setRoutineDetailId: row['set_routine_detail_id'],
        setCount: row['set_count'] ?? 0,
        setWeight: (row['set_weight'] as num?)?.toDouble(),
        setRepsCount: row['set_reps_count'],
        setDistance: row['set_distance'],
        setDuration: row['set_duration'],
      );

      exerciseMap[workoutId]?.setValueList.add(setEntity);
    }

   }
   return routineMap.values.toList();
  }

  @override
  Future<RoutineEntity?> getRoutineDetail(int routineId) async {
    final localData = await localDataSource.getRoutineDetails(routineId);

    if (localData.isEmpty) return null;

    final routineMap = <int, RoutineModel>{};
    final exerciseMap = <int, RoutineExerciseModel>{};

    for (final row in localData) {
      final routineId = row['routine_id'] as int? ?? 0;
      final workoutId = row['workout_id'] as int? ?? 0;
      final setId = row['set_id'] as int? ?? 0;

      routineMap.putIfAbsent(routineId, () {
        return RoutineModel(
          routineId: routineId,
          routineName: row['routine_name'] ?? '',
          routineCreatedPersonId: row['routine_created_person_id'],
          createdPersonName: row['created_person_name'],
          routineScope: row['routine_scope'],
          routineCreatedDate: row['routine_create_date'] != null && row['routine_create_date'] != ''
              ? DateTime.tryParse(row['routine_create_date'])
              : null,
          workoutList: [],
      );
      });

      if (workoutId != 0 && !exerciseMap.containsKey(workoutId)) {
        final exercise = RoutineExerciseModel(
          workoutId: workoutId,
          exerciseId: row['exercise_id'] ?? 0,
          exerciseName: row['exercise_name'],
          exerciseNote: row['exercise_note'],
          exerciseRestTime: row['exercise_rest_time'],
          routineID: routineId,
          setValueList: [],
        );

        exerciseMap[workoutId] = exercise;
        routineMap[routineId]?.workoutList?.add(exercise);
      }

      if (setId != 0) {
        final setEntity = RoutineSetModel(
          setId: setId,
          setRoutineDetailId: row['set_routine_detail_id'],
          setCount: row['set_count'] ?? 0,
          setWeight: (row['set_weight'] as num?)?.toDouble(),
          setRepsCount: row['set_reps_count'],
          setDistance: row['set_distance'],
          setDuration: row['set_duration'],
        );

        exerciseMap[workoutId]?.setValueList.add(setEntity);
      }

    }

    if (routineMap.isEmpty) {
      return null;
    }
    return routineMap.values.first;
  }
  
  @override
  Future<void> saveRoutine(RoutineEntity routine) async {
    final routineModel = RoutineModel(
      routineId: routine.routineId, 
      routineName: routine.routineName,
      routineCreatedPersonId: routine.routineCreatedPersonId,
      routineScope: routine.routineScope,
      routineCreatedDate: routine.routineCreatedDate,
      );

    // 1. Save routine header
    final routineId = await localDataSource.saveRoutineHeader(routineModel);

     // 2. Save each workout
    for (final workout in routine.workoutList ?? []) {
      final workoutModel = RoutineExerciseModel(
          exerciseId: workout.exerciseId, 
          routineID: routineId,
          exerciseRestTime: workout.exerciseRestTime,
          exerciseNote: workout.exerciseNote,
          setValueList: workout.setValueList,
        );

    final workoutId = await localDataSource.saveRoutineDetail(workoutModel);

    // 3. Save sets for this workout
    for(final setValues in workout.setValueList ?? []) {
      final setModel = RoutineSetModel(
        setRoutineDetailId: workoutId,
        setCount: setValues.setCount,
        setWeight: setValues.setWeight,
        setRepsCount: setValues.setRepsCount,
        setDistance: setValues.setDistance,
        setDuration: setValues.setDuration,
      );

    await localDataSource.saveWorkoutSet(setModel);
    }

    }

  }
  
  @override
  Future<void> saveWorkout(WorkoutSessionEntity session) async {
    try {
      await localDataSource.saveUserWorkoutData(session);
    } catch (e) {
      throw Exception("Failed to save user workout data: $e");
    }
  }


}