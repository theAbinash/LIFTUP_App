import 'package:liftup/core/database/db_helper.dart';
import 'package:liftup/feature/workout/data/models/routine_model.dart';
import 'package:liftup/feature/workout/data/models/routine_exercise_model.dart';
import 'package:liftup/feature/workout/data/models/routine_set_model.dart';
import 'package:liftup/feature/workout/domain/entities/workout_session_entity.dart';

abstract class RoutineLocalDataSource {
  Future<List<Map<String, dynamic>>> getRoutineList(int userId);
  Future<List<Map<String, dynamic>>> getRoutineDetails(int routineId);
  Future<List<RoutineSetModel>> getWorkoutSets(int workoutId);
  Future<int> saveRoutineHeader(RoutineModel routine);
  Future<int> saveRoutineDetail(RoutineExerciseModel workout);
  Future<int> saveWorkoutSet(RoutineSetModel set);
  Future<void> saveUserWorkoutData(WorkoutSessionEntity session);
  Future<void> updateRoutine(RoutineModel routine);
}

class RoutineLocalDataSourceImpl implements RoutineLocalDataSource {

  final DBHelper dbHelper;

  RoutineLocalDataSourceImpl({
    required this.dbHelper,
  });

  @override
  Future<List<Map<String, dynamic>>> getRoutineList(int userId) async {
    final db = await dbHelper.database;
    final result = await db.rawQuery('''
      SELECT * FROM vw_routine_full
      WHERE user_id = ?
      ORDER BY routine_id, workout_id, set_id;
    ''',
    [userId]);
    return result;
  }

  @override
  Future<List<Map<String, dynamic>>> getRoutineDetails(int routineId) async {
    final db = await dbHelper.database;
    final result = await db.query(
      "vw_routine_full",
      where: "routine_id = ?",
      whereArgs: [routineId],
    );
    return result;
  }

  @override
  Future<List<RoutineSetModel>> getWorkoutSets(int workoutId) async {
    final db = await dbHelper.database;
    final result = await db.query(
      "tb_routine_set",
      where: "rs_rd_id  = ?",
      whereArgs: [workoutId],
    );
    return result.map((e) => RoutineSetModel.fromMap(e)).toList();
  }
  
  @override
  Future<int> saveRoutineHeader(RoutineModel routine) async {
    final db = await dbHelper.database;
    return await db.insert("tb_routine_header", routine.toMap());
  }
    
  @override
  Future<int> saveRoutineDetail(RoutineExerciseModel workout) async {
    final db = await dbHelper.database;
    return await db.insert("tb_routine_detail", workout.toMap());
  }

  @override
  Future<int> saveWorkoutSet(RoutineSetModel set) async {
    final db = await dbHelper.database;
    return await db.insert("tb_routine_set", set.toMap());
  }
  
  @override
  Future<void> saveUserWorkoutData(WorkoutSessionEntity session) async {
    final db = await dbHelper.database;
    await db.transaction((txn) async {
      final wsId = await txn.insert(
        'tb_workout_session', 
        {
          'ws_rh_id': session.routineId,
          'ws_routine_name': session.routineName,
          'ws_user_id': session.userId,
          'ws_start_time': session.startTime.toIso8601String(),
          'ws_end_time': session.endTime?.toIso8601String(),
          'ws_status': session.isCompleted ? 1 : 0,
          'ws_total_volume': session.totalVolume,
          'ws_total_sets': session.totalSets,
          'ws_total_duration': session.durationMs,
          'ws_notes': session.notes,
          'timestamp': DateTime.now().toIso8601String(),
        }
        );

      for (int i = 0; i < session.exerciseList.length; i++) {
        final ex = session.exerciseList[i];

        final weId = await txn.insert(
          'tb_workout_exercise', 
          {
            'we_ws_id': wsId,
            'we_exercise_id': ex.exerciseId,
            'we_order': ex.exerciseSeqNo,
            'we_notes': ex.exerciseNote,
            'timestamp': DateTime.now().toIso8601String(),
          }
          );

        for (int j = 0; j < ex.setValueList.length; j++) {
          final set = ex.setValueList[j];

          await txn.insert(
            'tb_workout_set',
            {
              'wset_we_id': weId,
              'wset_rs_id': set.setId,
              'wset_actual_reps': set.setRepsCount,
              'wset_actual_weight': set.setWeight,
              'wset_actual_duration': set.setDuration,
              'wset_actual_distance': set.setDistance,
              'timestamp': DateTime.now().toIso8601String(),
            }
          );
        }
      }
    });
  }

  @override
  Future<void> updateRoutine(RoutineModel routine) async {
    final db = await dbHelper.database;

    await db.transaction((txn) async {
      // 1. Update header in place (keeps routineId stable)
      await txn.update(
        "tb_routine_header",
        routine.toMap(),
        where: "rh_id = ?",
        whereArgs: [routine.routineId],
      );

      // 2. Find existing detail rows so we can delete their child sets first
      final existingDetails = await txn.query(
        "tb_routine_detail",
        columns: ["rd_id"],
        where: "rd_rh_id = ?",
        whereArgs: [routine.routineId],
      );
      final existingDetailIds = existingDetails.map((r) => r['rd_id'] as int).toList();

      if (existingDetailIds.isNotEmpty) {
        final placeholders = List.filled(existingDetailIds.length, '?').join(',');
        
        // Find existing routine sets to clear foreign key references in workout sets
        final existingSets = await txn.query(
          "tb_routine_set",
          columns: ["rs_id"],
          where: "rs_rd_id IN ($placeholders)",
          whereArgs: existingDetailIds,
        );
        final existingSetIds = existingSets.map((r) => r['rs_id'] as int).toList();

        if (existingSetIds.isNotEmpty) {
          final setPlaceholders = List.filled(existingSetIds.length, '?').join(',');
          await txn.update(
            "tb_workout_set",
            {"wset_rs_id": null},
            where: "wset_rs_id IN ($setPlaceholders)",
            whereArgs: existingSetIds,
          );
        }

        await txn.delete(
          "tb_routine_set",
          where: "rs_rd_id IN ($placeholders)",
          whereArgs: existingDetailIds,
        );
      }

      // 3. Delete existing detail rows
      await txn.delete(
        "tb_routine_detail",
        where: "rd_rh_id = ?",
        whereArgs: [routine.routineId],
      );

      // 4. Re-insert current exercises + sets fresh
      for (final workout in routine.workoutList ?? []) {
        final workoutModel = RoutineExerciseModel(
          exerciseId: workout.exerciseId,
          routineID: routine.routineId,
          exerciseRestTime: workout.exerciseRestTime,
          exerciseNote: workout.exerciseNote,
          setValueList: workout.setValueList,
          restTimerEnabled: workout.restTimerEnabled,
          exerciseType: workout.exerciseType,
        );

        final workoutId = await txn.insert("tb_routine_detail", workoutModel.toMap());

        for (final setValues in workout.setValueList) {
          final setModel = RoutineSetModel(
            setRoutineDetailId: workoutId,
            setCount: setValues.setCount,
            setWeight: setValues.setWeight,
            setRepsCount: setValues.setRepsCount,
            setDistance: setValues.setDistance,
            setDuration: setValues.setDuration,
          );

          await txn.insert("tb_routine_set", setModel.toMap());
        }
      }
    });
  }

}