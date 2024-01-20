import 'package:artigian_app/model/model_barrel.dart';
import 'package:artigian_app/repositories/dbhelpers.dart';

import 'dart:async';

import 'package:sqflite/sqflite.dart';

class MaterialiProvider {
  final DBHelper _database = DBHelper.instance;

  static const String table = 'Materiali';
  static const String db_name = 'artigianApp.db';

  Future<Materiale> save(Materiale materiali) async {
    final dbClient = _database.db;
    try {
      await dbClient.insert('Materiali', materiali.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('problemi durante la CREAZIONE del registro nel database');
    }
    return materiali;
  }

  Future<int> update(Materiale materiale, int materialeID) async {
    var dbClient = _database.db;
    // final res;
    try {
      await dbClient.update('Materiali', materiale.toMap(),
          where: "id = ?", whereArgs: [materialeID]);
    } catch (e) {
      print("problemi durante la MODIFICA del registro");
    }
    return materialeID;
  }

  Future<List<Materiale>> getAllMaterialiDelCantiere(int cantiereID) async {
    var dbClient = _database.db;
    final res;
    try {
      res = await dbClient.query(table,
          where: "idCantiereM = ?",
          whereArgs: [cantiereID],
          orderBy: "ID DESC");
      if (res != null) {
        return res.map<Materiale>((m) => Materiale.fromMap(m)).toList();
      }
    } catch (e) {
      print('Registro Cantiere - Materiale non trovato');
    }
    return [];
    //return listMateriali;
  }

  Future<List<Materiale>> findMateriale(int materialeID, int cantiereID) async {
    var dbClient = _database.db;
    final result = await dbClient.query(table,
        where: "ID = ? AND idCantiereM = ?",
        whereArgs: [materialeID, cantiereID]);
    List<Materiale> listMateriali = result.isNotEmpty
        ? result.map<Materiale>((m) => Materiale.fromMap(m)).toList()
        : [];
    return listMateriali;
  }

  Future<List<Materiale>> getAllMateriali() async {
    var dbClient = _database.db;
    final res = await dbClient.query(table);
    List<Materiale> listMateriali = res.isNotEmpty
        ? res.map<Materiale>((m) => Materiale.fromMap(m)).toList()
        : [];
    return listMateriali;
  }

  Future<int> delete(int idMateriale, int idCantiere) async {
    var dbClient = _database.db;
    return await dbClient.delete(table,
        where: "ID = ? and idCantiereM = ?",
        whereArgs: [idMateriale, idCantiere]);
  }
}
