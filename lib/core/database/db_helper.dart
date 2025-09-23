import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  DBHelper._internal();
  factory DBHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("app_database.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tb_person_mtr (
        person_id INTEGER PRIMARY KEY AUTOINCREMENT,
        person_name TEXT,
        person_email TEXT,
        person_user_name TEXT,
        person_user_password TEXT,
        person_user_created_date TEXT,
        person_sex INTEGER,
        person_dob TEXT,
        timestamp TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE tb_exercise_mtr (
        exercise_id INTEGER PRIMARY KEY AUTOINCREMENT,
        exercise_name TEXT,
        exercise_image_url TEXT,
        exercise_etm_id INTEGER,
        exercise_equipments TEXT,
        exercise_primary_muscle TEXT,
        exercise_other_muscle TEXT,
        exercise_measurement_flag INTEGER,
        timestamp TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE tb_exercise_type_mtr (
        etm_id INTEGER PRIMARY KEY AUTOINCREMENT,
        etm_name TEXT,
        etm_has_reps INTEGER,
        etm_has_weight INTEGER,
        etm_has_negative_weight INTEGER,
        etm_has_duration INTEGER,
        etm_has_distance INTEGER,
        etm_notes TEXT,
        timestamp TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE tb_routine_header (
        rh_id INTEGER PRIMARY KEY AUTOINCREMENT,
        rh_name TEXT,
        rh_created_person_id INTEGER,
        rh_scope INTEGER,
        rh_create_date TEXT,
        timestamp TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE tb_routine_detail (
        rd_id INTEGER PRIMARY KEY AUTOINCREMENT,
        rd_rh_id INTEGER,
        rd_exercise_id INTEGER,
        rd_rest_timer INTEGER,
        rd_notes TEXT,
        timestamp TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE tb_routine_set (
        rs_id INTEGER PRIMARY KEY AUTOINCREMENT,
        rs_rd_id INTEGER,
        rs_set INTEGER,
        rs_weight DOUBLE,
        rs_reps INTEGER,
        rs_distance INTEGER,
        rs_duration INTEGER,
        timestamp TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

  }
}