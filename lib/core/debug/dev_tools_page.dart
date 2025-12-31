import 'dart:io';
import 'package:flutter/material.dart';
import 'package:liftup/core/database/db_helper.dart';
import 'package:liftup/core/session/session_manager.dart';
import 'package:liftup/core/utils/logger.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DevToolsPage extends StatefulWidget {
  const DevToolsPage({super.key});

  @override
  State<DevToolsPage> createState() => _DevToolsPageState();
}

class _DevToolsPageState extends State<DevToolsPage> {
  String _log = '';
  bool _loading = false;

  void _append(String message) {
    setState(() => _log += '$message\n');
  }

  Future<void> _checkDBFile() async {
    setState(() => _loading = true);
    final dbPath = await getDatabasesPath();
    final dbFile = File(join(dbPath, 'liftup_app.db'));
    final exists = await dbFile.exists();
    final sizeKB = exists ? (await dbFile.length() / 1024).toStringAsFixed(2) : '0';

    _append('DB Path: ${dbFile.path}');
    _append('Exists: $exists');
    _append('Size: $sizeKB KB');
    setState(() => _loading = false);
  }

  Future<void> _showRoutines() async {
    setState(() => _loading = true);
    final db = await DBHelper().database;
    final result = await db.rawQuery('SELECT rh_id,rh_name FROM tb_routine_header;');
    _append('Routines in DB: ${result.length}');
    for (final row in result) {
      _append('→ ${row['rh_id']}: ${row['rh_name']}');
    }
    setState(() => _loading = false);
  }

  Future<void> _showPersonMtr() async {
    setState(() => _loading = true);
    final db = await DBHelper().database;
    final result = await db.rawQuery('SELECT person_id,person_user_name FROM tb_person_mtr;');
    _append('Person in DB: ${result.length}');
    for (final row in result) {
      _append('→ ${row['person_id']}: ${row['person_user_name']}');
    }
    setState(() => _loading = false);
  }

  Future<void> _showSavedWorkouts() async {
    setState(() => _loading = true);
    final db = await DBHelper().database;
    final result = await db.rawQuery('SELECT ws_id,ws_routine_name,ws_total_sets FROM tb_workout_session;');
    _append('Workouts in DB: ${result.length}');
    for (final row in result) {
      _append(
      '→ #${row['ws_id']} '
      '${row['ws_routine_name']} | '
      'Sets: ${row['ws_total_sets']}'
    );
    }
    setState(() => _loading = false);
  }

  Future<void> exportDatabase() async {
    final dbPath = await getDatabasesPath();
    final source = File('$dbPath/liftup_app.db');

    if (!await source.exists()) {
        AppLogger.log('DB file not found: ${source.path}');
        return;
      }

    final Directory? dir = Directory('/storage/emulated/0/Download');
    if (dir == null) return;

    final dest = File('${dir.path}/gym_log_backup.db');

    await source.copy(dest.path);
    _append('DB copied to ${dest.path}');

    AppLogger.log('DB copied to ${dest.path}');
  }

  Future<void> _clearDatabase() async {
    setState(() => _loading = true);
    final dbPath = await getDatabasesPath();
    final file = File(join(dbPath, 'liftup_app.db'));
    if (await file.exists()) {
      await file.delete();
      await SessionManager.logout();
      _append('Database deleted!');
    } else {
      _append('No database file found to delete.');
    }
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Developer Tools')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _loading ? null : _checkDBFile,
                  icon: const Icon(Icons.folder),
                  label: const Text('Check DB File'),
                ),
                ElevatedButton.icon(
                  onPressed: _loading ? null : _showRoutines,
                  icon: const Icon(Icons.storage),
                  label: const Text('Show Routines'),
                ),
                ElevatedButton.icon(
                  onPressed: _loading ? null : _showPersonMtr,
                  icon: const Icon(Icons.storage),
                  label: const Text('Show Person Master'),
                ),
                ElevatedButton.icon(
                  onPressed: _loading ? null : _showSavedWorkouts,
                  icon: const Icon(Icons.storage),
                  label: const Text('Show Workout'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white
                  ),
                  onPressed: _loading ? null : exportDatabase,
                  icon: const Icon(Icons.download),
                  label: const Text('Download DB'),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    ),
                  onPressed: _loading ? null : _clearDatabase,
                  icon: const Icon(Icons.delete_forever),
                  label: const Text('Clear DB'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Colors.black,
                child: SingleChildScrollView(
                  child: Text(
                    _log,
                    style: const TextStyle(color: Colors.greenAccent, fontSize: 13),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
