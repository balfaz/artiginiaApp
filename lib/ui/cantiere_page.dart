import 'package:artigian_app/bloc/cantieri_bloc.dart';
import 'package:artigian_app/model/cantiere_model.dart';
import 'package:artigian_app/widget/custominput.dart';

import 'package:flutter/material.dart';

final ctrl_nomeC = TextEditingController();
final ctrl_indirizzoC = TextEditingController();
final ctrl_contattoC = TextEditingController();
final ctrl_telfC = TextEditingController();
final ctrl_emailC = TextEditingController();
final ctrl_dettC = TextEditingController();
final ctrl_dataIniC = TextEditingController();

FocusNode? myFocus;

class CantierePage extends StatefulWidget {
  final bool? fieldUpdate;
  final String? titleForm;
  final Cantiere? cantiereMod;

  const CantierePage(
      {super.key, this.fieldUpdate = false, this.titleForm, this.cantiereMod});

  @override
  _CantierePageState createState() => _CantierePageState();
}

class _CantierePageState extends State<CantierePage> {
  final _cantiere = CantieriBloc();

  _cleanPage() {
    setState(() {
      ctrl_nomeC.clear();
      ctrl_indirizzoC.clear();
      ctrl_contattoC.clear();
      ctrl_telfC.clear();
      ctrl_emailC.clear();
      ctrl_dataIniC.clear();
      ctrl_dettC.clear();
      ctrl_dataIniC.clear();
    });
  }

  @override
  void initState() {
    _cleanPage();
    if (widget.fieldUpdate!) prepareFormMod();
    myFocus = FocusNode();
    super.initState();
  }

  void prepareFormMod() {
    ctrl_nomeC.text = widget.cantiereMod!.nomeC!;
    ctrl_contattoC.text = widget.cantiereMod!.contattoC!;
    ctrl_indirizzoC.text = widget.cantiereMod!.indirizzoC!;
    ctrl_telfC.text = widget.cantiereMod!.telefC!;
    ctrl_emailC.text = widget.cantiereMod!.emailC!;
    ctrl_dettC.text = widget.cantiereMod!.dettagliC!;
    ctrl_dataIniC.text = widget.cantiereMod!.dataIniC!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titleForm!),
        centerTitle: true,
      ),
      body: const _FormCantiere(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Cantiere c;
          c = Cantiere(
              id: null,
              nomeC: ctrl_nomeC.text,
              contattoC: ctrl_contattoC.text,
              indirizzoC: ctrl_indirizzoC.text,
              telefC: ctrl_telfC.text,
              emailC: ctrl_emailC.text,
              dettagliC: ctrl_dettC.text,
              dataIniC: ctrl_dataIniC.text,
              dataInsert: ctrl_dataIniC.text);
          if (widget.fieldUpdate!) {
            //procedura switch per modificare o aggiungere
            _cantiere.modificaCantiere(c, widget.cantiereMod!.id!);
            Navigator.pushNamed(context, 'listaCantieri');
          } else {
            _cantiere.aggiungereCantiere(c);
            _cleanPage();
            myFocus!.requestFocus();
          }
        },
        child: Icon(widget.fieldUpdate! ? Icons.create : Icons.save),
      ),
    );
  }
}

class _FormCantiere extends StatefulWidget {
  const _FormCantiere({Key? key}) : super(key: key);

  @override
  __FormCantiereState createState() => __FormCantiereState();
}

class __FormCantiereState extends State<_FormCantiere> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView(
        children: [
          CustomInput(
            icon: Icons.assignment,
            placeHolder: 'Nome cantiere',
            textController: ctrl_nomeC,
            isFocus: myFocus!,
          ),
          CustomInput(
              icon: Icons.perm_identity,
              placeHolder: 'Contatto',
              textController: ctrl_contattoC),
          CustomInput(
              icon: Icons.public,
              placeHolder: 'Indirizzo',
              textController: ctrl_indirizzoC),
          CustomInput(
              icon: Icons.call,
              placeHolder: 'Telefono',
              textController: ctrl_telfC),
          CustomInput(
              icon: Icons.alternate_email,
              placeHolder: 'Email',
              textController: ctrl_emailC),
          CustomInput(
            icon: Icons.date_range,
            placeHolder: 'Data Inizio (dd/mm/aaaa)',
            textController: ctrl_dataIniC,
            keyboardType: TextInputType.datetime,
          ),
          CustomInput(
            icon: Icons.description,
            placeHolder: 'Dettagli',
            textController: ctrl_dettC,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
          ),
        ],
      ),
      //  ),
    );
  }
}
