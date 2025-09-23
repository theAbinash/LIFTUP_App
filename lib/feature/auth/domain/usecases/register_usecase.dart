
import 'package:gym_log/feature/auth/domain/entities/user_entity.dart';
import 'package:gym_log/feature/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase  {

  final AuthRepository repository;

  RegisterUseCase (this.repository);

  Future<void> call(UserEntity user){
    return repository.register(user);
  }
}