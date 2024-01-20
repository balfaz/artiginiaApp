/* import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;

      _database = await initDB();
      return _database;
    }
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "artigianapp_db.db");
  }
} */

/* class AADatabase {
  Database _db;

  initDB() async {
    _db = await openDatabase('artigianap_db.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE cantiere (id INTEGER PRIMARY KEY AUTOINCREMENT, nomeC TEXT NOT NULL, indirizzoC TEXT, contattoC TEXT, telefC TEXT, emailC TEXT, dataIniC TEXT NOT NULL, dettagliC TEXT, dataCreazC TEXT)');
      print('DB creato con successo');
    });
  }
} */
