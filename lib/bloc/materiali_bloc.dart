import 'dart:async';

import 'package:artigian_app/model/model_barrel.dart';
import 'package:artigian_app/repositories/materiali_provider.dart';

class MaterialiBloc {
  late int idMaterial, idCantiereM;
  final _materialiProvider = MaterialiProvider();
  static final MaterialiBloc _singletonMat = MaterialiBloc._internal();

  factory MaterialiBloc() {
    return _singletonMat;
  }

  MaterialiBloc._internal() {
    if (idCantiereM == null) idCantiereM = 0;
    materialeStream
        .listen((materialiList) => _materialiCounter.add(materialiList.length));
    mostraAllMaterialiDelCantiere(idCantiereM);
  }

  final _materialeController = StreamController<List<Materiale>>.broadcast();
  Stream<List<Materiale>> get materialeStream => _materialeController.stream;

  StreamController<int> _materialiCounter = StreamController<int>.broadcast();
  Stream<int> get materialiCounter => _materialiCounter.stream;

  dispose() {
    _materialeController.close();
    _materialiCounter.close();
  }

  aggiungereMateriale(Materiale materiale, int idCantiere) {
    _materialiProvider.save(materiale);
    mostraAllMaterialiDelCantiere(idCantiere);
  }

  modificaMateriale(Materiale materiale, int id, int idCantiere) {
    _materialiProvider.update(materiale, id);
    mostraAllMaterialiDelCantiere(idCantiere);
  }

  Future cercaMateriale({int? materialeID, int? idCantiere}) async {
    return await _materialiProvider.findMateriale(materialeID!, idCantiere!);
  }

  Future<List<Materiale>> mostraAllMaterialiDelCantiere(int idCantiere) async {
    if (idCantiere == 0 || idCantiere == null) return [];
    final listaMateriali = _materialeController.sink
        .add(await _materialiProvider.getAllMaterialiDelCantiere(idCantiere));
    return _materialiProvider.getAllMaterialiDelCantiere(idCantiere);
  }

  mostraAllMateriali() async {
    _materialeController.sink.add(await _materialiProvider.getAllMateriali());
  }

  cancellaMateriali(int id, int idCantiere) async {
    await _materialiProvider.delete(id, idCantiere);
    mostraAllMaterialiDelCantiere(idCantiere);
  }
}
