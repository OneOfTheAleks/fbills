import 'dart:async';
import 'package:fbills/models/models.dart';
import 'package:sqflite/sqflite.dart';

abstract class DB {


    static int get _version => 1;


 static Database? _db;
    static Future<void> init() async {

        if (_db != null) { return; }

        try {
            String path = '${await getDatabasesPath()}db';
            _db = await openDatabase(path, version: _version, onCreate: onCreate);
        }
        catch(ex) { 
            print(ex);
        }
    }

    static void onCreate(Database db, int version) async =>() async {
        await db.execute('CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY NOT NULL, name STRING)');
        await db.execute('CREATE TABLE IF NOT EXISTS bill_items (id INTEGER PRIMARY KEY NOT NULL, name STRING, operationType INTEGER, remains REAL,user_id INTEGER, FOREIGN KEY(user_id) REFERENCES users(id) )');
        
};
    static Future<Future<List<Map<String, Object?>>>?> query(String table) async => _db?.query(table);

    static Future<int?> insert(String table, Model model) async =>
        await _db?.insert(table, model.toMap());
    
    static Future<int?> update(String table, Model model) async =>
        await _db?.update(table, model.toMap(), where: 'id = ?', whereArgs: [model.id]);

    static Future<int?> delete(String table, Model model) async =>
        await _db?.delete(table, where: 'id = ?', whereArgs: [model.id]);
}

