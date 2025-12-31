import 'package:liftup/core/database/db_helper.dart';
import 'package:liftup/feature/workout/data/models/exercise_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class ExerciseLocalDataSource {
  Future<void> saveExerciseList(List<ExerciseModel> dataList);
  Future<List<ExerciseModel>> getExerciseList();
  Future<void> clearExercises();
}

class ExerciseLocalDataSourceImpl implements ExerciseLocalDataSource {

  final DBHelper dbHelper;

  ExerciseLocalDataSourceImpl({
    required this.dbHelper,
  });

  @override
  Future<void> saveExerciseList(List<ExerciseModel> dataList) async {
    final db = await dbHelper.database;
    final batch = db.batch();
    for(var data in dataList){
      batch.insert("tb_exercise_mtr", data.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  @override
  Future<List<ExerciseModel>> getExerciseList() async {
    final db = await dbHelper.database;
    final result = await db.query("tb_exercise_mtr");
    return result.map((e) => ExerciseModel.fromMap(e)).toList();
  }

  @override
  Future<void> clearExercises() async {
    final db = await dbHelper.database;
    await db.delete("tb_exercise_mtr");
  }
  
}