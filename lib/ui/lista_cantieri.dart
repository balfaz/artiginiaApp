//TODO: ATTIVARE LE VALIDAZIONI DEI CAMPI, FORMATO E TRIM PER IL TESTO
// PREPARARE PROCEDURA DELETE PER CANCELLARE DATI DALLA TABELLA MATERIALI

import 'package:artigian_app/bloc/cantieri_bloc.dart';
import 'package:artigian_app/model/cantiere_model.dart';
import 'package:artigian_app/ui/materiali_cantiere_page.dart';
import 'package:artigian_app/ui/cantiere_page.dart';
import 'package:artigian_app/widget/mostrar_dialogbox.dart';

import 'package:flutter/material.dart';

class ListaCantieriPage extends StatefulWidget {
  @override
  _ListaCantieriPageState createState() => _ListaCantieriPageState();
}

class _ListaCantieriPageState extends State<ListaCantieriPage> {
  var cantieriBloc;

  refreshList() {
    setState(() {});
  }

  @override
  void initState() {
    cantieriBloc = CantieriBloc();
    super.initState();
  }

  var size;
  @override
  void dispose() {
    //cantieriBloc.dispose();
    //print('bloc cant eliminato');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('artigianAPP'),
        actions: [
          SizedBox(
              child: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              //TODO: procedura per la chiusura oggetti dati e dispose adapters
              //Navigator.popAndPushNamed(context, 'listaCantieri');
            },
          ))
        ],
      ),
      body: _listViewCantieri(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'cantiere');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _listViewCantieri() {
    return StreamBuilder<List<Cantiere>>(
      stream: cantieriBloc.cantieriStream,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: snapshot.data!.length,
            itemBuilder: (_, i) => _cantiereListTile(snapshot, i),
            separatorBuilder: (_, i) => const Divider(
              height: 0.3,
            ),
            padding: const EdgeInsets.symmetric(vertical: 5.0),
          );
        } else if (snapshot.data == null) {
          return const CircularProgressIndicator();
        }
        return const Center(child: Text('Nessun <CANTIERE> trovato'));
      },
    );
  }

  _cantiereListTile(AsyncSnapshot cantiere, int index) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue[500],
        child: Text(
          (index + 1).toString(),
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
      ),
      title: Text(
        cantiere.data[index].nomeC,
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        cantiere.data[index].contattoC,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (context) => CantierePage(
                          fieldUpdate: true,
                          titleForm: 'Modifica cantiere',
                          cantiereMod: cantiere.data[index],
                        ));
                Navigator.push(context, route);
              }),
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                final action = await Dialogs.mostrartDialogBox(
                    context: context,
                    titulo: 'Conferma operazione',
                    subtitulo: 'Sei sicuro di voler Eliminare?',
                    btnNO: 'No',
                    btnSi: 'Si');
                if (action == DialogAction.ok) {
                  cantieriBloc.cancellaCantiere(cantiere.data[index].id);
                  cantieriBloc.mostraAllCantieri();
                }
              }),
          IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_right,
              size: 22.0,
            ),
            onPressed: () {
              // var route = );
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MaterialiCantierePage(
                            cantiere: cantiere.data[index],
                          )));
            },
          ),
        ],
      ),
    );
  }
}
