import 'package:liftup/feature/workout/domain/entities/routine_entity.dart';

abstract class RoutineDetailState {}

class RoutineDetailInitial extends RoutineDetailState{}

class RoutineDetailLoading extends RoutineDetailState{}

class RoutineDetailLoaded extends RoutineDetailState {
  final RoutineEntity routine;
  final bool isEditing;
  RoutineDetailLoaded({required this.routine, this.isEditing = false});
}

class RoutineWorkoutSave extends RoutineDetailState {}

class RoutineDetailError extends RoutineDetailState {
  final String message;
  RoutineDetailError(this.message);
}