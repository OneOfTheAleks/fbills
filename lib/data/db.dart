import 'dart:async';
import 'package:fbills/models/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "my_database.db";
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database ??  await openDatabase(inMemoryDatabasePath, version: _databaseVersion, onCreate: _onCreate);
  }

  _initDatabase() async {
    final path = await _getPath();
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  _getPath() async {
    return join(await getDatabasesPath(), _databaseName);
  }





  _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL
          )
          ''');
  }


}


class MyDatabase {
  MyDatabase({required this.db});

  final Database db;

  Future<List<Map<String, dynamic>>> getAllRows() async {
    return await db.query('my_table');
  }

  Future<void> insertRow(Map<String, dynamic> row) async {
    await db.insert('my_table', row);
  }

  Future<void> updateRow(Map<String, dynamic> row) async {
    await db.update('my_table', row);
  }

  Future<void> deleteRow(int id) async {
    await db.delete('my_table', where: 'id = ?', whereArgs: [id]);
  }
}