import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class dbHelperInterFace {
  Future<dynamic> get_all(String query);
}

class DbHelper implements dbHelperInterFace {
  static String DB_NAME = "db_vakil";
  static String TB_CONFIG = "tb_config";
  static String THEORY_HEADERS = "theory_headers";
  static String THEORIES = "theories";
  static String VAHDAT_HEADERS = "vahdat_headers";
  static String VAHDATS = "vahdats";
  static String TERMS = "terms_fa";
  static String LEGALS = "legals";
  static String LEGAL_HEADERS = "legal_headers";
  static String LEGAL_CHILDS = "legal_childs";

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDB();
    return _db!;
  }

  initDB() async {
    // io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    // //String path = join('assets/db/', DB_NAME);
    // String path = join(documentDirectory.path, DB_NAME);
    // var db = await openDatabase(path, version: 2, onCreate: _onCreate);
    //
    // return db;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'db_vakil');
    final exists = await databaseExists(path);
    var db;
    if (exists) {
      print('database Alredy');
      db = await openDatabase(path);
    } else {
      print('create a copy database in assets');
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (ex) {}
      ByteData data = await rootBundle.load(join('assets/db', DB_NAME));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
      db = await openDatabase(path);
      print('db coped');
    }
    print('database OK');
    return db;
  }

  _onCreate(Database db, int version) async {
    String query = "CREATE TABLE ${TB_CONFIG}(id INTEGER PRIMARY KEY "
        "configkey TEXT,"
        "configvalue TEXT)";
    try {
      await db.execute(query);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<int> insertByQuery(String sql) async {
    try {
      var dbClient = await db;
      return await dbClient.rawInsert(sql);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<int> insertByQueryModel(String table, final obj) async {
    try {
      var dbClient = await db;
      print('insert bulk $table start');
      var result = await dbClient.insert(table, obj);
      print('insert bulk $table end');
      return result;
    } catch (e) {
      print('insert bulk ${e.toString()} end');
      throw e.toString();
    }
  }

  Future<int> deleteByQuery(String sql) async {
    try {
      var dbClient = await db;
      // return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
      return await dbClient.rawDelete(sql);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<int> updateByQuery(String sql) async {
    try {
      var dbClient = await db;
      // return await dbClient.update(TABLE, employe.toMap(),
      //     where: '$ID = ?', whereArgs: [employe.id]);
      return await dbClient.rawUpdate(sql);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> tableCheckExists(String tbName) async {
    var dbClient = await db;
    String query =
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tbName'";
    var res = await dbClient.rawQuery(query);
    if (res.isNotEmpty) {
      print('table $tbName is exists');
      return true;
    }
    print('table $tbName is Notexists');
    return false;
  }

  Future<int> insertByModel(var lists, String tableName) async {
    try {
      var dbClient = await db;
      print('insert bulk start');
      Batch batch = dbClient.batch();
      lists.forEach((line) {
        batch.insert(tableName, line.toMap());
      });
      var res = await batch.commit();
      print('insert bulk end');
      return lists.length;
    } catch (e) {
      print('insert bulk ${e.toString()} end');
      throw e.toString();
    }
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }

  deleteTable(String tableName) async {
    try {
      String query = "drop table if exists $tableName";
      var dbClient = await db;
      dbClient.execute(query);
      print('Drop table $tableName succesffly');
    } catch (e) {
      print('Drop table $tableName failed ' + e.toString());
    }
  }

  Future<List<Map>> select({required String sql}) async {
    var dbClient = await db;
    debugPrint(sql);
    List<Map> maps = await dbClient.rawQuery(sql);

    return maps;
  }

  @override
  Future<dynamic> get_all(String query) async {
    try {
      return await select(sql: query);
    } on Exception catch (ex) {
      rethrow;
    }
  }
}
