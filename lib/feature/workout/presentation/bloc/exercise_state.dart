import 'package:gym_log/feature/workout/domain/entities/exercise_entity.dart';

abstract class ExerciseState {
  List<ExerciseEntity> get exercises => [];
  Set<int> get selectedIds => {};
}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoading extends ExerciseState {}

class ExerciseLoaded extends ExerciseState {

  @override
  final List<ExerciseEntity> exercises;
  @override
  final Set<int> selectedIds;

  ExerciseLoaded({required this.exercises, required this.selectedIds});

}

class ExerciseError extends ExerciseState {
  final String message;
  ExerciseError(this.message);
}