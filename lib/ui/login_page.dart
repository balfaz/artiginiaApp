import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import 'package:artigian_app/global/verifica_email.dart';
import 'package:artigian_app/widget/btn_azul.dart';
import 'package:artigian_app/widget/custominput.dart';
import 'package:artigian_app/widget/labels.dart';
import 'package:artigian_app/widget/logo_app.dart';
import 'package:artigian_app/widget/dialog_resetpassword.dart';

import 'package:artigian_app/repositories/auth_services.dart';
import 'package:artigian_app/ui/home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.92,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const LogoApp(
                titolo: 'ArtigianApp',
              ),
              const _Form(),
              FilledButton(
                  //focusColor: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DialogResetPassword(
                                context: context,
                                titulo: 'Reset password',
                                subtitulo:
                                    'Se la email è corretta noi invieremo \n un messaggio a questo account',
                                btnNO: 'Annulla',
                                btnSi: 'Invia')));
                  },
                  child: const Text('Hai dimenticato la password?',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400))),
              const Labels(
                titulo: 'Non sei registrato?',
                subtitle: 'Crea tuo account',
                ruta: 'register',
              ),
              const Text(
                'Termini e condizioni d`uso',
                style: TextStyle(fontWeight: FontWeight.w200),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _pswdCtrl = TextEditingController();
  final AuthService _authService = AuthService();

  _cleanForm() {
    _emailCtrl.clear();
    _pswdCtrl.clear();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _pswdCtrl.dispose(); // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 30),
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: [
              CustomInput(
                icon: Icons.mail_outline,
                placeHolder: 'Email',
                isPassword: false,
                textController: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                validator: (email) =>
                    (EmailGiusta(email) && email.toString().isNotEmpty)
                        ? null
                        : 'formato <Email> non valido',
                saved: (email) => _emailCtrl.text = email,
              ),
              CustomInput(
                  icon: Icons.lock_outline,
                  placeHolder: 'Password',
                  isPassword: true,
                  textController: _pswdCtrl,
                  keyboardType: TextInputType.text,
                  validator: (psw) => (psw.toString().trim().isNotEmpty &&
                          psw.toString().length >= 8)
                      ? null
                      : '- Password deve avere almeno 8 caratteri\n- Valore <vuoto> non valido',
                  saved: (psw) => _pswdCtrl.text = psw),
              ButtonBlue(
                  text: 'Inizia',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _authService
                          .autenticandoSignIn(_emailCtrl.text, _pswdCtrl.text)
                          .then((userExist) {
                        if (userExist != null) {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => HomePage(
                                        email: userExist.toString(),
                                      )));
                        }
                      }).catchError((error) {
                        Fluttertoast.showToast(
                            msg: 'Login/Password non corrette\nRiprovare...',
                            backgroundColor: Colors.red[200],
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            toastLength: Toast.LENGTH_LONG);
                        _cleanForm();
                      });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
