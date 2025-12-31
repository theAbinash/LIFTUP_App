import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';

class WorkoutSessionEntity {
  final int? workoutSessionId;
  final int routineId;
  final String routineName;
  final int userId;
  final DateTime startTime;
  final DateTime? endTime;
  final String? notes;
  final int? totalSets;
  final double? totalVolume;
  final int? durationMs;
  final List<RoutineExerciseEntity> exerciseList;
  bool isCompleted;
  int? elapsedMilliseconds;

  WorkoutSessionEntity({
    required this.workoutSessionId,
    required this.routineId,
    required this.routineName,
    required this.userId,
    required this.startTime,
    this.endTime,
    this.notes,
    this.totalSets,
    this.totalVolume,
    this.durationMs,
    this.exerciseList = const[],
    this.isCompleted = false,
    this.elapsedMilliseconds,
  });

  WorkoutSessionEntity copyWith({
    int? workoutSessionId,
    int? routineId,
    String? routineName,
    int? userId,
    DateTime? startTime,
    DateTime? endTime,
    String? notes,
    List<RoutineExerciseEntity>? exerciseList,
    bool? isCompleted,
    int? elapsedMilliseconds,
    int? totalSets,
    double? totalVolume,
    int? durationMs,
  }) {
    return WorkoutSessionEntity(
      workoutSessionId: workoutSessionId ?? this.workoutSessionId,
      routineId: routineId ?? this.routineId,
      routineName: routineName ?? this.routineName,
      userId: userId ?? this.userId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      notes: notes ?? this.notes,
      exerciseList: exerciseList ?? this.exerciseList,
      isCompleted: isCompleted ?? this.isCompleted,
      elapsedMilliseconds:
          elapsedMilliseconds ?? this.elapsedMilliseconds,
      totalSets: totalSets ?? this.totalSets,
      totalVolume: totalVolume ?? this.totalVolume,
      durationMs: durationMs ?? this.durationMs,
    );
  }

  Duration get elapsedDuration =>
      Duration(milliseconds: elapsedMilliseconds ?? 0);

  set elapsedDuration(Duration d) => elapsedMilliseconds = d.inMilliseconds;
}