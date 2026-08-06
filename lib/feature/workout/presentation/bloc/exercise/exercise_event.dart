import 'package:equatable/equatable.dart';

abstract class ExerciseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadExercises extends ExerciseEvent {}

class RefreshExercise extends ExerciseEvent {}

class FilterExercises extends ExerciseEvent {
  final String searchQuery;
  final List<String> equipments;
  final List<String> muscles;

  FilterExercises({
    this.searchQuery = "",
    this.equipments = const [],
    this.muscles = const [],
  });
}

class ToggleSelection extends ExerciseEvent {
  final int exerciseId;
  ToggleSelection(this.exerciseId);
}