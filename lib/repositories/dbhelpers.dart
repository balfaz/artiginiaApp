import 'package:path/path.dart';

import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const String ID = 'id';
  static const String nomeC = 'nomeC';
  static const String indirizzoC = 'indirizzoC';
  static const String contattoC = 'contattoC';
  static const String telefC = 'telefC';
  static const String emailC = 'emailC';
  static const String dataIniC = 'dataIniC';
  static const String dettagliC = 'dettagliC';
  static const String dataInsert = 'dataInsert';

  static const String table = 'Cantiere';
  static const String db_name = 'artigianApp.db';

  DBHelper._();
  static final DBHelper instance = DBHelper._();

  late Database _db;

  Database get db {
    if (_db == null) _db = initDB();
    return _db;
  }

  initDB() async {
    var path = await getDatabasePath(db_name);
    _db = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpdate);
  }

  Future<String> getDatabasePath(String dbName) async {
    final databasePath = await getDatabasesPath();
    var path = join(databasePath, db_name);
    if (!await Directory(dirname(path)).exists()) {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> _onCreate(Database db, int version) async {
    const tableCantiere =
        '''CREATE TABLE Cantiere (ID INTEGER PRIMARY KEY, nomeC TEXT NOT NULL,
            indirizzoC TEXT, contattoC TEXT, telefC TEXT, emailC TEXT, 
            dataIniC TEXT NOT NULL, dettagliC TEXT, dataInsert TEXT) ''';
    await db.execute(tableCantiere);
    print('tbl Cantiere Creato');
    const tableMateriali =
        '''CREATE TABLE Materiali (ID INTEGER PRIMARY KEY, idCantiereM INTEGER NOT NULL,
            descrizioneM TEXT, qtaM REAL, tipoUnitaM TEXT, costoNetoM REAL) ''';
    await db.execute(tableMateriali);
    print('tbl Materiale create!');
  }

  Future<void> _onUpdate(Database db, int oldVersion, int newVersion) async {
    /*  if (oldVersion < newVersion) {
      const dropTable = '''DROP TABLE Materiali ''';
      await db.execute(dropTable);      
    } */
  }

  Future close() async {
    var dbClient = _db;
    dbClient.close();
  }
}
