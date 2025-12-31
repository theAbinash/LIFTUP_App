import 'package:liftup/feature/workout/domain/entities/routine_entity.dart';
import 'package:liftup/feature/workout/domain/repositories/routine_repository.dart';

class GetRoutineDetailUsecase {
  final RoutineRepository repository;

  GetRoutineDetailUsecase(this.repository);

  Future<RoutineEntity?> call(int routineId) {
    return repository.getRoutineDetail(routineId);
  }
}