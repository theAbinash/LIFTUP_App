import 'package:liftup/feature/workout/domain/entities/exercise_entity.dart';

abstract class ExerciseRepository {
  Future<List<ExerciseEntity>> getExerciseList({bool forceRefresh = false});
}