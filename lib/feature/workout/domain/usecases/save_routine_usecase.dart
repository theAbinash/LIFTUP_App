import 'package:liftup/feature/workout/domain/entities/routine_entity.dart';
import 'package:liftup/feature/workout/domain/repositories/routine_repository.dart';

class SaveRoutineUsecase {

  final RoutineRepository repository;

  SaveRoutineUsecase(this.repository);

  Future<void> call(RoutineEntity routine){
    return repository.saveRoutine(routine);
  }

}