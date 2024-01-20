import 'dart:io';

import 'package:artigian_app/model/materiale_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//TODO: Aggiungere una gif animata per DialogBox

Materiale? m;

//enum DialogAction { annulla, modifica }

List<Materiale>? listMat;
String dropdownValue = 'Kg.';
final ctrlDesc = TextEditingController();
final ctrlQta = TextEditingController();
Materiale? nwMateriale;

class ModificaPopup extends StatefulWidget {
  final String titulo;
  final Materiale listMat;

  final myFunction;
  ModificaPopup(
      {Key? key, required this.titulo, required this.listMat, this.myFunction})
      : super(key: key);

  @override
  _ModificaPopupState createState() => _ModificaPopupState();
}

class _ModificaPopupState extends State<ModificaPopup> {
  var result;
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      result = showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Modifica materiale'),
          content: PopupPage(
            m: widget.listMat,
          ),
          actions: [
            MaterialButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: Text('Annulla'),
              elevation: 5,
              textColor: Colors.blue,
            ),
            MaterialButton(
              onPressed: () {
                final Materiale m = Materiale(
                    descrizioneM: ctrlDesc.text,
                    qtaM: double.parse(ctrlQta.text.toString()),
                    tipoUnitaM: dropdownValue);
                widget.myFunction(m);
                Navigator.of(context).pop();
              },
              //=> Navigator.pop(context),
              child: Text('Modifica'),
              elevation: 5,
              textColor: Colors.blue,
            )
          ],
        ),
      );
    }
    if (Platform.isIOS) {
      /*  result = showCupertinoDialog(
          context: context,
          builder: (_) => CupertinoAlertDialog(
                title: Text('Modifica materiale'),
                content: PopupPage(),
                actions: [
                  CupertinoDialogAction(
                    child: Text('Annulla'),
                    isDefaultAction: true,
                    onPressed: () =>
                        Navigator.of(context).pop(DialogAction.annulla),
                  ),
                  CupertinoDialogAction(
                    child: Text('Modifica'),
                    onPressed: () =>
                        Navigator.of(context).pop(DialogAction.modifica),
                  )
                ],
              )); */
    }
    return result;
  }
}

class PopupPage extends StatefulWidget {
  final Materiale? m;
  const PopupPage({Key? key, this.m}) : super(key: key);

  @override
  _PopupPageState createState() => _PopupPageState();
}

class _PopupPageState extends State<PopupPage> {
  @override
  Widget build(BuildContext context) {
    //dropdownValue = widget.m.tipoUnitaM;
    ctrlDesc.text = widget.m!.descrizioneM!;
    ctrlQta.text = widget.m!.qtaM.toString();

    return Container(
      //color: Colors.blueGrey[100],
      alignment: Alignment.topCenter,
      height: MediaQuery.of(context).size.height * 0.18,
      //width: size.width * 0.98,
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: inputMateriali(ctrlDesc, 'Descrizione', FocusNode()),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Expanded(
                flex: 1,
                child: inputMateriali(ctrlQta, 'Qta', FocusNode()),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: buildDropdownButton(),
              ),
              /*   Expanded(
                flex: 1,
                child: IconButton(
                    icon: Icon(
                      Icons.add_circle,
                      size: 40.0,
                    ),
                    onPressed: () {
                      m = Materiale(
                          id: null,
                          idCantiereM: 1, //TODO: da modificare dopo prova
                          descrizioneM: ctrlDesc.text.trim(),
                          qtaM: double.parse(ctrlQta.text),
                          costoNetoM: '0.00',
                          tipoUnitaM: dropdownValue.trim());
                      //setState(() {
                      listMat.add(m);
                      //});
                    }),
              ) */
            ],
          )
        ],
      ),
    );
  }

  buildDropdownButton() {
    return Container(
      alignment: Alignment.center,
      child: DropdownButton<String>(
        iconSize: 30.0,
        value: dropdownValue,
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['Kg.', 'Un.', 'Lt.', 'Mt.']
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
}

inputMateriali(TextEditingController ctrl, String testo, FocusNode focus) {
  return Container(
      padding: const EdgeInsets.only(left: 3.0),
      margin: const EdgeInsets.only(left: 2.0),
      child: TextField(
        textAlignVertical: TextAlignVertical.top,
        controller: ctrl,
        autocorrect: false,
        focusNode: focus,
        decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            hintText: testo),
      ));
}
