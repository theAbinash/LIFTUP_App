import 'package:liftup/feature/workout/domain/entities/routine_entity.dart';
import 'package:liftup/feature/workout/domain/entities/workout_session_entity.dart';

abstract class RoutineRepository {
  Future<List<RoutineEntity>> getRoutineList({bool forceRefresh = false,});
  Future<RoutineEntity?> getRoutineDetail(int routineId);
  Future<void> saveRoutine(RoutineEntity routine);
  Future<void> updateRoutine(RoutineEntity routine);
  //Future<void> deleteRoutine(int routineId);
  Future<void> saveWorkout(WorkoutSessionEntity session);
}