import 'package:flutter/material.dart';

class Cantiere {
  @required
  int? id;
  @required
  String? nomeC;
  String? indirizzoC;
  String? contattoC;
  String? telefC;
  String? emailC;
  String? dataIniC;
  String? dettagliC;
  String? dataInsert;

  Cantiere(
      {this.id,
      this.nomeC,
      this.contattoC,
      this.indirizzoC,
      this.telefC,
      this.emailC,
      this.dataIniC,
      this.dettagliC,
      this.dataInsert});

  //trasforma l'oggetto in MAP
  Map<String, dynamic> toMap() => {
        //'ID': id,
        'nomeC': nomeC,
        'indirizzoC': indirizzoC,
        'contattoC': contattoC,
        'telefC': telefC,
        'emailC': emailC,
        'dataIniC': dataIniC,
        'dettagliC': dettagliC,
        'dataInsert': dataInsert
      };

  Cantiere.fromMap(Map<String, dynamic> cantiereMap) {
    id = cantiereMap['ID'];
    nomeC = cantiereMap['nomeC'];
    indirizzoC = cantiereMap['indirizzoC'];
    contattoC = cantiereMap['contattoC'];
    telefC = cantiereMap['telefC'];
    emailC = cantiereMap['emailC'];
    dataIniC = cantiereMap['dataIniC'];
    dettagliC = cantiereMap['dettagliC'];
    dataInsert = cantiereMap['dataInsert'];
  } //trasforma il MAP in oggetto

  /*  @override //Ottenere descrizione dell'oggetto
  String toString() {
    return 'Cantiere{ id: $id, nomeC: $nomeC, indirizzoC: $indirizzoC, contattoC: $contattoC, telefC: $telefC, emailC: $emailC, dataIniC: $dataIniC, dettagliC: $dettagliC, dataInsert: $dataInsert}';
  } */
}
