import 'dart:async';

import 'package:artigian_app/model/model_barrel.dart';
import 'package:artigian_app/repositories/cantiere_provider.dart';

class CantieriBloc {
  static final CantieriBloc _singletonCant = CantieriBloc._internal();
  final _db = CantiereProvider();

  factory CantieriBloc() {
    return _singletonCant;
  }

  CantieriBloc._internal() {
    mostraAllCantieri();
  }

  final _cantieriController = StreamController<List<Cantiere>>.broadcast();
  Stream<List<Cantiere>> get cantieriStream => _cantieriController.stream;

  dispose() {
    _cantieriController?.close();
  }

  aggiungereCantiere(Cantiere cantiere) {
    _db.save(cantiere);
    mostraAllCantieri();
  }

  modificaCantiere(Cantiere cantiere, int id) {
    _db.update(cantiere, id);
    mostraAllCantieri();
  }

  mostraCantierePerId(int id) async {
    return await _db.getCantierePerId(id);
  }

  mostraAllCantieri() async {
    _cantieriController.sink.add(await _db.getAllCantieri());
  }

  cancellaCantiere(int id) async {
    await _db.delete(id);
    mostraAllCantieri();
  }
}
