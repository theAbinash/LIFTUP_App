
import 'package:gym_log/core/database/db_helper.dart';
import 'package:gym_log/feature/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<int> insertUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<UserModel?> validateUser(String email, String password);
  Future<void> logout();
  Future<int> deleteUser(int id);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {

  final DBHelper dbHelper;
  final SharedPreferences prefs;

  static const _keyUserId = "logged_in_user_id";

  AuthLocalDataSourceImpl({
    required this.dbHelper,
    required this.prefs
  });

  @override
  Future<int> insertUser(UserModel user) async {
    final db = await dbHelper.database;
    final userId = await db.insert('tb_person_mtr', user.toMap());
    await prefs.setInt(_keyUserId, userId);
    return userId;
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final db = await dbHelper.database;
    final userId = prefs.getInt(_keyUserId);

    if(userId == null) return null;

    final result = await db.query(
      'tb_person_mtr',
      where: 'person_id = ?',
      whereArgs: [userId],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    }
    return null;
  }

  @override
  Future<UserModel?> validateUser(String email, String password) async {
    final db = await dbHelper.database;
    final result = await db.query(
      'tb_person_mtr',
      where: 'person_email = ? AND person_user_password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      final user = UserModel.fromMap(result.first);
      await prefs.setInt(_keyUserId, user.id!);
      return user;
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await prefs.remove(_keyUserId);
  }

  @override
  Future<int> deleteUser(int id) async {
    final db = await dbHelper.database;
    return await db.delete(
      'tb_person_mtr',
      where: 'person_id = ?',
      whereArgs: [id],
    );
  }
  
}