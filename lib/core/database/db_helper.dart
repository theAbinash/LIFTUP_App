import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  DBHelper._internal();
  factory DBHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("liftup_app.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
      onOpen: (db) async {
        await db.execute('PRAGMA foreign_keys = ON;');
      },
    );
  }

  Future<void> _createTables(Database db, int version) async {

    await db.execute('''
      DROP VIEW IF EXISTS vw_routine_full;
    ''');

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
        timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
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
        timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
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
        timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE tb_routine_header (
        rh_id INTEGER PRIMARY KEY AUTOINCREMENT,
        rh_name TEXT,
        rh_created_person_id INTEGER,
        rh_scope INTEGER,
        rh_create_date DATETIME,
        timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE tb_routine_detail (
        rd_id INTEGER PRIMARY KEY AUTOINCREMENT,
        rd_rh_id INTEGER REFERENCES tb_routine_header(rh_id),
        rd_exercise_id INTEGER REFERENCES tb_exercise_mtr(exercise_id),
        rd_rest_timer INTEGER,
        rd_notes TEXT,
        timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE tb_routine_set (
        rs_id INTEGER PRIMARY KEY AUTOINCREMENT,
        rs_rd_id INTEGER REFERENCES tb_routine_detail(rd_id),
        rs_set INTEGER,
        rs_weight DOUBLE,
        rs_reps INTEGER,
        rs_distance INTEGER,
        rs_duration INTEGER,
        timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE tb_workout_session (
          ws_id INTEGER PRIMARY KEY AUTOINCREMENT,
          ws_rh_id INTEGER REFERENCES tb_routine_header(rh_id),
          ws_routine_name TEXT,
          ws_user_id INTEGER,
          ws_start_time DATETIME,
          ws_end_time DATETIME,
          ws_status INTEGER,
          ws_total_volume DOUBLE,
          ws_total_sets INTEGER,
          ws_total_duration DOUBLE,
          ws_notes TEXT,
          timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE tb_workout_exercise (
          we_id INTEGER PRIMARY KEY AUTOINCREMENT,
          we_ws_id INTEGER REFERENCES tb_workout_session(ws_id),
          we_exercise_id INTEGER REFERENCES tb_exercise_mtr(exercise_id),
          we_order INTEGER,
          we_notes TEXT,
          timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE tb_workout_set (
          wset_id INTEGER PRIMARY KEY AUTOINCREMENT,
          wset_we_id INTEGER REFERENCES tb_workout_exercise(we_id),
          wset_rs_id INTEGER REFERENCES tb_routine_set(rs_id),
          wset_set INTEGER,
          wset_actual_reps INTEGER,
          wset_actual_weight DOUBLE,
          wset_actual_duration DOUBLE,
          wset_actual_distance INTEGER,
          timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE TABLE tb_workout_media (
          wm_id INTEGER PRIMARY KEY AUTOINCREMENT,
          wm_ws_id INTEGER REFERENCES tb_workout_session(ws_id),
          wm_url TEXT,
          wm_type INTEGER,
          wm_person_id INTEGER REFERENCES tb_person_mtr(person_id),
          timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    await db.execute('''
      CREATE VIEW IF NOT EXISTS vw_routine_full AS
      SELECT 
        rh.rh_id AS routine_id,
        rh.rh_name AS routine_name,
        rh.rh_created_person_id AS routine_created_person_id,
        rh.rh_scope AS routine_scope,
        rh.rh_create_date AS routine_create_date,

        rd.rd_id AS workout_id,
        rd.rd_rh_id AS workout_routine_id,
        rd.rd_exercise_id AS exercise_id,
        em.exercise_name AS exercise_name,
        rd.rd_notes AS exercise_note,
        rd.rd_rest_timer AS exercise_rest_time,

        rs.rs_id AS set_id,
        rs.rs_rd_id AS set_routine_detail_id,
        rs.rs_set AS set_count,
        rs.rs_weight AS set_weight,
        rs.rs_reps AS set_reps_count,
        rs.rs_distance AS set_distance,
        rs.rs_duration AS set_duration,
        pm.person_user_name AS created_person_name,
        pm.person_id AS user_id,

        wset.wset_set,
        wset.wset_actual_reps AS actual_reps_count,
        wset.wset_actual_weight AS actual_weight,
        wset.wset_actual_distance AS actual_distance,
        wset.wset_actual_duration AS actual_duration,
        ws.ws_start_time AS workout_start_time, 
        ws.ws_end_time AS workout_end_time,
        ws.ws_total_duration AS ws_tot_duration,
        ws.ws_total_volume AS ws_tot_volume, 
        ws.ws_total_sets AS ws_tot_sets

      FROM tb_routine_header rh
      LEFT JOIN tb_routine_detail rd ON rh.rh_id = rd.rd_rh_id 
      LEFT JOIN tb_person_mtr pm ON pm.person_id = rh.rh_created_person_id
      LEFT JOIN tb_exercise_mtr em ON em.exercise_id = rd.rd_exercise_id
      LEFT JOIN tb_routine_set rs ON rd.rd_id = rs.rs_rd_id
      LEFT JOIN tb_workout_session ws ON ws.ws_rh_id = rh.rh_id
      LEFT JOIN tb_workout_exercise we ON we.we_ws_id = ws.ws_id AND we.we_exercise_id = em.exercise_id
      LEFT JOIN tb_workout_set wset ON wset.wset_we_id = we.we_id AND wset.wset_rs_id = rs.rs_id
      GROUP BY rh.rh_id, rd.rd_exercise_id
      ORDER BY rh.rh_id, rd.rd_id, rs.rs_id;
    ''');

    await db.execute('CREATE INDEX IF NOT EXISTS idx_routine_detail_rh_id ON tb_routine_detail(rd_rh_id);');
    await db.execute('CREATE INDEX IF NOT EXISTS idx_routine_set_rd_id ON tb_routine_set(rs_rd_id);');

  }
}