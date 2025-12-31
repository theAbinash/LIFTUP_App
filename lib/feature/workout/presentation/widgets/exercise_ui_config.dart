import 'package:liftup/core/utils/constants.dart';

class ExerciseUIConfig {
  final bool showWeight;
  final bool showDuration;
  final bool showDistance;
  final bool showReps;

  const ExerciseUIConfig({
    this.showWeight = false,
    this.showDuration = false,
    this.showDistance = false,
    this.showReps = false,
  });
}

ExerciseUIConfig getExerciseUIConfig(int? type) {
  switch (type) {
    case Constants.exerciseTypeWithDistanceAndWeight:
      return const ExerciseUIConfig(
        showWeight: true,
        showDistance: true,
      );

    case Constants.exerciseTypeWithWeightAndDuration:
      return const ExerciseUIConfig(
        showWeight: true,
        showDuration: true,
      );

    case Constants.exerciseTypeWithWeightAndReps:
      return const ExerciseUIConfig(
        showWeight: true,
        showReps: true,
      );

    case Constants.exerciseTypeWithDurationOnly:
      return const ExerciseUIConfig(
        showDuration: true,
      );

    case Constants.exerciseTypeWithDistanceOnly:
      return const ExerciseUIConfig(
        showDistance: true,
      );

    case Constants.exerciseTypeWithReps:
      return const ExerciseUIConfig(
        showReps: true,
      );

    default:
      return const ExerciseUIConfig();
  }
}
