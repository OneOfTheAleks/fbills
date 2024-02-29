import 'dart:async';
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
    return _database ??
        await openDatabase(inMemoryDatabasePath,
            version: _databaseVersion, onCreate: _onCreate);
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
    await db.transaction((txn) async {
      // txn is a Transaction object
      await txn.execute(
          '''
          CREATE TABLE IF NOT EXISTS users (
            id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            note TEXT
          )
          ''');
      await txn.execute(
          '''
          CREATE TABLE IF NOT EXISTS bills (
            id INTEGER PRIMARY KEY,
            user_id  INTEGER NOT NULL REFERENCES users(id),
            date DATE NOT NULL,
            name TEXT NOT NULL,
            note TEXT
          )
          ''');
    });
  }
}

class MyDatabase {
  MyDatabase({required this.db});

  final Database db;

  Future<List<Map<String, dynamic>>> getAllUserRows() async {
    return await db.query('users');
  }

  Future<void> insertUserRow(Map<String, dynamic> row) async {
    await db.insert('users', row);
  }

  Future<void> updateUserRow(Map<String, dynamic> row) async {
    await db.update('users', row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<void> deleteUserRow(int id) async {
    await db.transaction((txn) async {
      await txn.delete('users', where: 'id = ?', whereArgs: [id]);
      await txn.delete('bills', where: 'user_id = ?', whereArgs: [id]);
    });
  }

  Future<List<Map<String, dynamic>>> getUserRow(int id) async {
    return await db.query('users', where: 'id = ?', whereArgs: [id]);
  }
}
