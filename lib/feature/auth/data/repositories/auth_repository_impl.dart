
import 'package:gym_log/feature/auth/data/datasources/auth_local_data_source.dart';
import 'package:gym_log/feature/auth/data/models/user_model.dart';
import 'package:gym_log/feature/auth/domain/entities/user_entity.dart';
import 'package:gym_log/feature/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.localDataSource
    });

  @override
  Future<UserEntity> login(String personEmail, String personUserPassword) async {
    final user = await localDataSource.validateUser(personEmail, personUserPassword);
    if (user == null) {
      throw Exception("Invalid email or password");
    }
    return user;
  }

  @override
  Future<int> register(UserEntity user) async {
    final userModel = UserModel(
      id: user.id,
      email: user.personEmail,
      personUserName: user.personUserName,
      personUserPassword: user.personUserPassword,
    );
    return await localDataSource.insertUser(userModel);
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final user = await localDataSource.getCachedUser();
    if (user == null) {
      throw Exception("No cached user found");
    }
    return user;
  }

  @override
  Future<void> logout() async {
    await localDataSource.logout();
  }
  
  @override
  Future<int> deleteUser(int id) async {
    return await localDataSource.deleteUser(id);
  }
  
}