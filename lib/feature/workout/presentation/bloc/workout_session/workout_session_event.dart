import 'package:equatable/equatable.dart';

abstract class WorkoutSessionEvent extends Equatable {
  const WorkoutSessionEvent();

  @override
  List<Object?> get props => [];
}

class WorkoutStarted extends WorkoutSessionEvent {
  const WorkoutStarted();
}

class WorkoutTicked extends WorkoutSessionEvent {
  const WorkoutTicked();
}

class WorkoutPaused extends WorkoutSessionEvent {
  const WorkoutPaused();
}

class WorkoutResumed extends WorkoutSessionEvent {
  const WorkoutResumed();
}

class ToggleSetCompleted extends WorkoutSessionEvent {
  final int exerciseIndex;
  final int setIndex;

  const ToggleSetCompleted({
    required this.exerciseIndex,
    required this.setIndex,
  });

  @override
  List<Object?> get props => [
        exerciseIndex,
        setIndex,
      ];
}