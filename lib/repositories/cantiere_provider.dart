import 'package:artigian_app/model/model_barrel.dart';
import 'package:artigian_app/repositories/dbhelpers.dart';
import 'package:sqflite/sqflite.dart';

class CantiereProvider {
  static const String table = 'Cantiere';
  static const String db_name = 'artigianApp.db';
  final DBHelper _database = DBHelper.instance;

  Future<Cantiere> save(Cantiere cantiere) async {
    final dbClient = _database.db;
    final res = await dbClient.insert(table, cantiere.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return cantiere;
  }

  Future<int> update(Cantiere cantiere, int cantiereID) async {
    var dbClient = _database.db;
    final res = await dbClient.update(table, cantiere.toMap(),
        where: "ID = ?", whereArgs: [cantiereID]);
    return res;
  }

  Future<List<Cantiere>> getAllCantieri() async {
    var dbClient = _database.db;
    final res = await dbClient.query(table);
    List<Cantiere> listCantieri =
        res.isNotEmpty ? res.map((c) => Cantiere.fromMap(c)).toList() : [];
    return listCantieri;
  }

  Future<List<Cantiere>> getCantierePerId(int id) async {
    var dbClient = _database.db;
    final res = await dbClient.query(table, where: "ID = ?", whereArgs: [id]);
    List<Cantiere> listCantieri =
        res.isNotEmpty ? res.map((c) => Cantiere.fromMap(c)).toList() : [];
    return listCantieri;
  }

  Future<int> delete(int id) async {
    var dbClient = _database.db;
    return await dbClient.delete(table, where: "ID = ?", whereArgs: [id]);
  }
}
