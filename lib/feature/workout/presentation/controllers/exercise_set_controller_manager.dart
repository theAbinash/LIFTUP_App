import 'package:liftup/feature/workout/domain/entities/routine_set_entity.dart';

import 'exercise_set_controller.dart';

class ExerciseSetControllerManager {
  final Map<int, ExerciseSetController> _controllers = {};

  ExerciseSetController controllerFor(RoutineSetEntity set) {
    final key = set.setRoutineDetailId ?? set.hashCode;

    return _controllers.putIfAbsent(
      key,
      () => ExerciseSetController(
        weight: set.setWeight?.toString() ?? '',
        reps: set.setRepsCount?.toString() ?? '',
        distance: set.setDistance?.toString() ?? '',
        duration: set.setDuration?.toString() ?? '',
      ),
    );
  }

  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _controllers.clear();
  }
}