import 'package:artigian_app/bloc/cantieri_bloc.dart';
import 'package:artigian_app/bloc/materiali_bloc.dart';
import 'package:artigian_app/model/model_barrel.dart';
import 'package:artigian_app/widget/customInputNoIcon.dart';
import 'package:artigian_app/widget/mostrar_dialogbox.dart';
import 'package:flutter/material.dart';

MaterialiBloc? _materialiBloc;
CantieriBloc? _cantieriBloc;

class MaterialiCantierePage extends StatefulWidget {
  Cantiere? cantiere = Cantiere();
  MaterialiCantierePage({Key? key, this.cantiere}) : super(key: key);

  @override
  _MaterialiCantierePage createState() => _MaterialiCantierePage();
}

class _MaterialiCantierePage extends State<MaterialiCantierePage> {
  @override
  void initState() {
    super.initState();
    _materialiBloc = MaterialiBloc();
    _cantieriBloc = CantieriBloc();
    _aggiornaList(widget.cantiere!.id);
  }

  Future<void> _aggiornaList(int? cantiereID) async {
    _materialiBloc!.mostraAllMaterialiDelCantiere(cantiereID!);
    //setState(() {});
  }

  String dropdownValue = 'Kg.';
  final ctrlDesc = TextEditingController();
  final ctrlQta = TextEditingController();
  final ctrlDescM = TextEditingController();
  final ctrlQtaM = TextEditingController();

  late Materiale m;
  var size;
  bool isExpanded = false;
  Materiale? nwMateriale;
  FocusNode myFocus = FocusNode();
  int _counterItems = 0;

  _modPopup(int idMateriale, int idCantiere) async {
    var matMod;
    try {
      matMod = await _materialiBloc!
          .cercaMateriale(idCantiere: idCantiere, materialeID: idMateriale);
    } catch (e) {
      print(
          '<_modalPopup>: problema riscontrato durante la modifica del Item, $e');
    }

    final _cantiere = await _cantieriBloc!.mostraCantierePerId(idCantiere);

    ctrlDescM.text = matMod[0].descrizioneM;
    ctrlQtaM.text = matMod[0].qtaM.toString();
    dropdownValue = matMod[0].tipoUnitaM;
    final result = showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Modifica materiale',
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: Colors.black87),
        ),
        content: Container(
          //color: Colors.blue[200],
          alignment: Alignment.topCenter,
          height: MediaQuery.of(context).size.height * 0.25,
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: inputDescrizione(
                            context, ctrlDescM, 'Descrizione', FocusNode())),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: customInputNoIcon(
                        context, ctrlQtaM, 'Qta', FocusNode()),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: buildDropdownButton(),
                  ),
                ],
              )
            ],
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(MaterialiCantierePage(
              cantiere: _cantiere,
            )),
            child: Text('Annulla'),
            elevation: 5,
            textColor: Colors.blue,
          ),
          MaterialButton(
            onPressed: () {
              final Materiale m = Materiale();
              m.id = matMod[0].id;
              m.idCantiereM = matMod[0].idCantiereM;
              m.descrizioneM = ctrlDescM.text;
              m.qtaM = double.parse(ctrlQtaM.text);
              m.tipoUnitaM = dropdownValue;
              m.costoNetoM = matMod[0].costoNetoM;
              _materialiBloc!
                  .modificaMateriale(m, matMod[0].id, matMod[0].idCantiereM);
              Navigator.of(context).pop();
            },
            child: Text('Modifica'),
            elevation: 5,
            textColor: Colors.blue,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    myFocus.dispose();
    ctrlDesc.dispose();
    ctrlDescM.dispose();
    ctrlQta.dispose();
    ctrlQtaM.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Materiali cantiere'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.blueGrey[100],
              alignment: Alignment.center,
              //width: size.width * 0.98,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: customInputNoIcon(
                        context, ctrlDesc, 'Descrizione', myFocus),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    flex: 1,
                    child:
                        customInputNoIcon(context, ctrlQta, 'Qta', FocusNode()),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    flex: 1,
                    child: buildDropdownButton(),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                        icon: Icon(
                          Icons.add_circle,
                          size: 38.0,
                        ),
                        onPressed: () {
                          m = Materiale(
                              id: null,
                              idCantiereM: widget.cantiere!
                                  .id, //TODO: da modificare dopo prova
                              descrizioneM: ctrlDesc.text.trim(),
                              qtaM: double.parse(ctrlQta.text),
                              costoNetoM: 0,
                              tipoUnitaM: dropdownValue.trim());
                          _materialiBloc!
                              .aggiungereMateriale(m, widget.cantiere!.id!);
                          clearCamps();
                          setState(() {});
                        }),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Expanded(
              child: listaMateriali(),
            ),
            infoLista(),
          ],
        ),
      ),
    );
  }

  buildDropdownButton() {
    return Container(
      height: 42.0,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0, 5),
                blurRadius: 5.0)
          ]),
      child: DropdownButton<String>(
        iconSize: 28.0,
        value: dropdownValue,
        underline: Container(
            padding:
                EdgeInsets.only(top: 1.0, left: 2.0, right: 10.0, bottom: 1.0),
            margin: EdgeInsets.only(bottom: 1.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 5),
                      blurRadius: 5.0)
                ])),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['Kg.', 'Un.', 'Lt.', 'Mt.', 'Ore']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                textAlign: TextAlign.center,
              ));
        }).toList(),
      ),
    );
  }

  listaMateriali() {
    return StreamBuilder<List<Materiale>>(
        stream: _materialiBloc!.materialeStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            _counterItems = snapshot.data!.length;
            return ListView.builder(
              reverse: false,
              itemCount: snapshot.data!.length, //CONTROLLA questa istruzione
              scrollDirection: Axis.vertical,
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: (index % 2 == 0)
                            ? Colors.blue[200]
                            : Colors.grey[300]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(left: 10.0),
                                width: MediaQuery.of(context).size.width * 0.67,
                                child: Text(
                                  snapshot.data![index].descrizioneM!,
                                  style: const TextStyle(fontSize: 16.0),
                                ),
                              ),
                              //VerticalDivider(),
                              Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width * 0.12,
                                child: Text(
                                    snapshot.data![index].qtaM!
                                        .toStringAsFixed(2),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14)),
                              ),
                              Text(
                                snapshot.data![index].tipoUnitaM.toString(),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          onTap: () {
                            _modPopup(snapshot.data![index].id!,
                                snapshot.data![index].idCantiereM!);
                          },
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        IconButton(
                            icon: const Icon(
                              Icons.delete,
                            ),
                            onPressed: () async {
                              final action = await Dialogs.mostrartDialogBox(
                                  context: context,
                                  titulo: 'Conferma operazione',
                                  subtitulo: 'Sei sicuro di voler Eliminare?',
                                  btnNO: 'Annulla',
                                  btnSi: 'Elimina');
                              if (action == DialogAction.ok) {
                                _materialiBloc!.cancellaMateriali(
                                    snapshot.data![index].id!,
                                    snapshot.data![index].idCantiereM!);
                              }
                            }),
                      ],
                    ),
                    //),
                  ),
                );
              },
            );
          } else if (snapshot.data.toString() == '[]') {
            return const Center(
                child: Text('Nessun <MATERIALE> per questo cantiere'));
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void clearCamps() {
    ctrlDescM.clear();
    ctrlQtaM.clear();
    ctrlDesc.clear();
    ctrlQta.clear();
    dropdownValue = 'Kg.';
    myFocus.requestFocus();
  }

  infoLista() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.10,
        color: Colors.white,
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          children: [
            const Divider(
              color: Colors.black87,
              //height: 2.0,
              thickness: 3,
            ),
            const SizedBox(
              height: 8.0,
            ),
            StreamBuilder(
              stream: _materialiBloc!.materialiCounter,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Totale items: ${snapshot.data}',
                    style: const TextStyle(
                        fontSize: 26.0, fontWeight: FontWeight.w500),
                  ),
                );
              },
            ),
          ],
        ));
  }
}
