import 'package:gym_log/feature/workout/domain/entities/exercise_entity.dart';
import 'package:gym_log/feature/workout/domain/repositories/exercise_repository.dart';

class GetExerciseUsecase {
  final ExerciseRepository repository;

  GetExerciseUsecase(this.repository);

  Future<List<ExerciseEntity>> call({bool forceRefresh = false}) {
    return repository.getExerciseList(forceRefresh: forceRefresh);
  }
}