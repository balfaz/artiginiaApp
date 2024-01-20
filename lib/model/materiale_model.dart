import 'package:flutter/material.dart';

//TODO: cambiare campo costoNetoM to double
class Materiale {
  @required
  int? id;
  @required
  int? idCantiereM;
  String? descrizioneM;
  double? qtaM;
  String? tipoUnitaM;
  double? costoNetoM;

  Materiale({
    this.id,
    this.idCantiereM,
    this.descrizioneM,
    this.qtaM,
    this.tipoUnitaM,
    this.costoNetoM,
  });

  //trasforma l'oggetto in MAP
  Map<String, dynamic> toMap() => {
        'idCantiereM': idCantiereM,
        'descrizioneM': descrizioneM,
        'qtaM': qtaM,
        'tipoUnitaM': tipoUnitaM,
        'costoNetoM': costoNetoM
      };

  Materiale.fromMap(Map<String, dynamic> materialeMap) {
    id = materialeMap['ID'];
    idCantiereM = materialeMap['idCantiereM'];
    descrizioneM = materialeMap['descrizioneM'];
    qtaM = materialeMap['qtaM'];
    tipoUnitaM = materialeMap['tipoUnitaM'];
    costoNetoM = materialeMap['costoNetoM'].toDouble();
  }
}
