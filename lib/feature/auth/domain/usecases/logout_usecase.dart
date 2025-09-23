
import 'package:gym_log/feature/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase {

  final AuthRepository repository;

  LogoutUsecase(this.repository);

  Future<void> call(){
    return repository.logout();
  }
}