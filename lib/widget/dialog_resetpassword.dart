import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:artigian_app/global/verifica_email.dart';
import 'package:artigian_app/repositories/auth_services.dart';
import 'package:artigian_app/widget/custominput.dart';
import 'package:artigian_app/widget/logo_app.dart';

class DialogResetPassword extends StatefulWidget {
  final BuildContext? context;
  final String? titulo;
  final String? subtitulo;
  final String? btnNO;
  final String? btnSi;
  DialogResetPassword(
      {Key? key,
      this.context,
      this.titulo,
      this.subtitulo,
      this.btnNO,
      this.btnSi})
      : super(key: key);

  @override
  _DialogResetPasswordState createState() => _DialogResetPasswordState();
}

class _DialogResetPasswordState extends State<DialogResetPassword> {
  final _keyForm = GlobalKey<FormState>();
  var action;
  final _ctrlEmailReset = TextEditingController();
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Form(
        key: _keyForm,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const LogoApp(
                titolo: 'ArtigianApp',
              ),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(0, 5),
                              blurRadius: 5.0)
                        ]),
                    width: MediaQuery.of(context).size.width * 0.80,
                    height: MediaQuery.of(context).size.height * 0.38,
                    child: Column(children: [
                      Text(
                        widget.titulo!,
                        style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(widget.subtitulo!),
                      const SizedBox(
                        height: 15.0,
                      ),
                      CustomInput(
                        icon: Icons.email_outlined,
                        placeHolder: 'Email',
                        textController: _ctrlEmailReset,
                        validator: (email) =>
                            (email.toString().trim().isNotEmpty &&
                                    EmailGiusta(email))
                                ? null
                                : 'formato <Email> non valido',
                        saved: (email) => _ctrlEmailReset.text = email,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                            onPressed: () => Navigator.of(context)
                                .pushReplacementNamed('login'),
                            textColor: Colors.blue,
                            child: Text(widget.btnNO!),
                          ),
                          MaterialButton(
                            onPressed: () {
                              if (_keyForm.currentState!.validate()) {
                                _auth
                                    .onRecoveryPsw(_ctrlEmailReset.text.trim())
                                    .then((send) => null);
                                Navigator.of(context)
                                    .pushReplacementNamed('login');
                              }
                            },
                            textColor: Colors.blue,
                            child: Text(widget.btnSi!),
                          )
                        ],
                      )
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
