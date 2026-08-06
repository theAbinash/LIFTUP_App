import 'package:equatable/equatable.dart';
import 'package:liftup/feature/workout/data/models/routine_model.dart';
import 'package:liftup/feature/workout/domain/entities/workout_session_entity.dart';

abstract class RoutineEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadRoutine extends RoutineEvent{}

class RefreshRoutine extends RoutineEvent{}

class SaveRoutine extends RoutineEvent{
  final RoutineModel routine;

  SaveRoutine(this.routine);
}

class LoadRoutineDetail extends RoutineEvent{
  final int routineId;
  LoadRoutineDetail (this.routineId);
}

class SaveWorkoutData extends RoutineEvent{
  final WorkoutSessionEntity session;
  SaveWorkoutData(this.session);
}

class UpdateRoutine extends RoutineEvent {
  final RoutineModel routine;
  UpdateRoutine(this.routine);
}