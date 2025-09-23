import 'package:gym_log/feature/auth/domain/entities/user_entity.dart';
import 'package:gym_log/feature/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<UserEntity?> call() {
    return repository.getCurrentUser();
  }
}
