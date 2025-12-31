import 'package:equatable/equatable.dart';
import 'package:liftup/feature/workout/domain/entities/workout_session_entity.dart';

abstract class RoutineDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadRoutineDetail extends RoutineDetailEvent {
  final int routineId;
  LoadRoutineDetail(this.routineId);
}

class SaveWorkout extends RoutineDetailEvent {
  final WorkoutSessionEntity session;
  SaveWorkout(this.session);
}

class ToggleEditRoutine extends RoutineDetailEvent {
  final bool isEditing;
  ToggleEditRoutine(this.isEditing);
}

