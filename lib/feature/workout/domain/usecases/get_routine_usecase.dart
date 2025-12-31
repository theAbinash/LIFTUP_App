import 'package:liftup/feature/workout/domain/entities/routine_entity.dart';
import 'package:liftup/feature/workout/domain/repositories/routine_repository.dart';

class GetRoutineUsecase {
  final RoutineRepository repository;

  GetRoutineUsecase(this.repository);

  Future<List<RoutineEntity>> call({bool forceRefresh = false}) {
    return repository.getRoutineList(forceRefresh: forceRefresh);
  }
}