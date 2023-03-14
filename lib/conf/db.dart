

import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DataBaseHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _table = "taches";

  static Future<void> initDb() async {
    _db = null;
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}task.db';
      _db = await openDatabase(
        path,
        version: _version,
        onCreate: (_db, _version) {
         print("table created");
         return _db.execute(
           "CREATE TABLE $_table("
               "id INTEGER PRIMARY KEY AUTOINCREMENT ,"
               "title STRING,"
               "note TEXT, date STRING,"
               "startTime STRING, endTime STRING,"
               "remind INTEGER, repeat STRING,"
               "color INTEGER,"
               "isCompleted INTEGER)",
         );
        }
      );
    } catch(e){
      print(e);
    }
  }

  static Future<void> tableDelete() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}task.db';
      _db = await openDatabase(
          path,
          version: _version,
          onCreate: (db, _version) {
            print("TABLE DELETED");
            return db.execute(
              "DROP TABLE $_table",
            );
          }
      );
    } catch(e){
      print(e);
    }
  }

  static Future<int> insert(Task? task) async {
    print("INSERT");
    return await _db?.insert(_table, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("QUERY FUNC CALLED");
    return await _db!.query(_table);
  }

}