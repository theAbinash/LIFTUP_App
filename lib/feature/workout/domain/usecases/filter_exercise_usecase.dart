import 'package:liftup/feature/workout/domain/entities/exercise_entity.dart';

class FilterExerciseUsecase {

  List<ExerciseEntity> call (
    List<ExerciseEntity> exercise,
    {
      String searchQuery = "",
      List<String> equipments = const [],
      List<String> muscles = const [],
    }
  ) {
    return exercise.where((exercise) {
      final matchesSearch = exercise.exerciseName.toLowerCase()
          .contains(searchQuery.toLowerCase());

      final matchesEquipment = equipments.isEmpty ||
          exercise.exerciseEquipments.any((e) => equipments.contains(e));

      final matchesMuscle = muscles.isEmpty ||
          exercise.exerciseBodyParts.any((m) => muscles.contains(m));

      return matchesSearch && matchesEquipment && matchesMuscle;
    }).toList();
  }
}