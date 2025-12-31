import 'package:liftup/feature/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String personEmail, String personUserPassword);
  Future<int> register(UserEntity user);
  Future<UserEntity?> getCurrentUser();
  Future<void> logout();
  Future<int> deleteUser(int id);
}