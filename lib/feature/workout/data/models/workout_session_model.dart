import 'package:liftup/feature/workout/domain/entities/workout_session_entity.dart';

class WorkoutSessionModel extends WorkoutSessionEntity {
  final int? workoutSessionId;
  final int routineId;
  final String routineName;
  final int userId;
  final DateTime startTime;
  final DateTime? endTime;
  final String? notes;

  WorkoutSessionModel({
    this.workoutSessionId,
    required this.routineId,
    required this.routineName,
    required this.userId,
    required this.startTime,
    this.endTime,
    this.notes,
  }) : super(
      workoutSessionId: workoutSessionId, routineId: routineId, routineName: routineName,
      startTime: startTime, userId: userId, endTime: endTime, notes: notes,
      );

  Map<String, dynamic> toMap() {
    final map = {
      'ws_rh_id': routineId,
      'ws_user_id': userId,
      'ws_start_time': startTime.toIso8601String(),
      'ws_end_time': endTime?.toIso8601String(),
      'ws_notes': notes,
    };
    if (workoutSessionId != null) map['ws_id'] = workoutSessionId;
    return map;
  }

  factory WorkoutSessionModel.fromMap(Map<String, dynamic> map) {
    return WorkoutSessionModel(
      workoutSessionId: map['ws_id'],
      routineId: map['ws_rh_id'],
      userId: map['ws_user_id'],
      startTime: DateTime.parse(map['ws_start_time']),
      endTime: map['ws_end_time'] != null ? DateTime.parse(map['ws_end_time']) : null,
      notes: map['ws_notes'], 
      routineName: '',
    );
  }
}