import 'dart:async';

import '../model/tache.dart';
import 'package:sqflite/sqflite.dart';
import '../globals/tache_globals.dart';

class TacheHelper {
  //singleInstance

  TacheHelper._privateConstructor();
  static TacheHelper? _instance;
  static TacheHelper? get instance =>
      _instance ??= TacheHelper._privateConstructor();

  Future<Database?>? _db;
  Future<Database?> getDatabase() async {
    if (_db != null) {
      return await _db;
    }

    _db = _initialseDatabse();
    return await _db;
  }

  Future<Database?> _initialseDatabse() async {
    String dir = await getDatabasesPath();
    String path = "${dir}${TacheGlobals.dbName}";
    return openDatabase(path, onCreate: _onCreate, version: 1);
  }

  FutureOr<void> _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE ${TacheGlobals.table}(
        ${TacheGlobals.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${TacheGlobals.columnTitle} TEXT,
        ${TacheGlobals.columnStatus} TEXT
      )
''');
  }

  Future<List<Map<String, Object?>>> getAll() async {
    Database? db = await getDatabase();
    return Future.delayed(Duration(milliseconds: 400), () async {
      return await db!.rawQuery("SELECT * FROM ${TacheGlobals.table}");
    });
  }

  Future<int> add(Tache tache) async {
    Database? db = await getDatabase();
    return await db!.insert(TacheGlobals.table, tache.toMap());
  }

  Future<int> deleteAll() async {
    Database? db = await getDatabase();
    return await db!.delete(TacheGlobals.table);
  }

  Future<int> delete(int id) async {
    Database? db = await getDatabase();
    return await db!.delete(TacheGlobals.table,
        where: "${TacheGlobals.columnId} = ?", whereArgs: [id]);
  }

  Future<int> update(Tache tache) async {
    Database? db = await getDatabase();

    return await db!.rawUpdate(
        "UPDATE ${TacheGlobals.table} SET ${TacheGlobals.columnStatus} = ?, ${TacheGlobals.columnTitle} = ? WHERE ${TacheGlobals.columnId} = ?",
        [tache.status, tache.title, tache.id]);
  }
}
