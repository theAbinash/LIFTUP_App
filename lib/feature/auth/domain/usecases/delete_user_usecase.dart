import 'package:gym_log/feature/auth/domain/repositories/auth_repository.dart';

class DeleteUserUseCase {
  final AuthRepository repository;

  DeleteUserUseCase(this.repository);

  Future<int> call(int id) {
    return repository.deleteUser(id);
  }
}
