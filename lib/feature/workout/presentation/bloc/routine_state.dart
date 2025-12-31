import 'package:liftup/feature/workout/domain/entities/routine_entity.dart';
import 'package:liftup/feature/workout/domain/entities/routine_exercise_entity.dart';
import 'package:liftup/feature/workout/domain/entities/workout_session_entity.dart';

abstract class RoutineState {
  List<RoutineExerciseEntity> get workoutList => [];
  List<RoutineEntity> get routineList => [];
}

class RoutineInitial extends RoutineState{}

class RoutineLoading extends RoutineState{}

class RoutineLoaded extends RoutineState{
  
  @override
  final List<RoutineEntity> routineList;

  RoutineLoaded({required this.routineList});
}

class RoutineDetailLoaded  extends RoutineState{
  @override
  final RoutineEntity? routine;
  RoutineDetailLoaded(this.routine);
}

class RoutineError extends RoutineState{
  final String message;
  RoutineError(this.message);
}

class SaveWorkoutSuccess extends RoutineState{
  final WorkoutSessionEntity session;
  SaveWorkoutSuccess(this.session);
}