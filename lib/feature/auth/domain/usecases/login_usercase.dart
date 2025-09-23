
import 'package:gym_log/feature/auth/domain/entities/user_entity.dart';
import 'package:gym_log/feature/auth/domain/repositories/auth_repository.dart';

class LoginUsercase {
  final AuthRepository repository;

  LoginUsercase(this.repository);

  Future<UserEntity> call(String personEmail, String personUserPassword){
    return repository.login(personEmail, personUserPassword);
  }
}