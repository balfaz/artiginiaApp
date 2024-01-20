import 'package:artigian_app/global/verifica_email.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:artigian_app/repositories/auth_services.dart';
import 'package:artigian_app/widget/btn_azul.dart';
import 'package:artigian_app/widget/custominput.dart';
import 'package:artigian_app/widget/labels.dart';
import 'package:artigian_app/widget/logo_app.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LogoApp(
                titolo: 'ArtigianApp',
              ),
              _Form(),
              Labels(
                titulo: 'Sei già registrato?',
                subtitle: 'Inizia sessione',
                ruta: 'login',
              ),
              Text(
                'Termini e condizioni d`uso',
                style: TextStyle(fontWeight: FontWeight.w200),
              )
            ],
          ),
        ),
      ),
      //),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({Key? key}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final _formkey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _pswdCtrl = TextEditingController();
  final _verPswCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _pswdCtrl.dispose();
    _verPswCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
    return Form(
      key: _formkey,
      child: Container(
        margin: const EdgeInsets.only(top: 28),
        padding: const EdgeInsets.symmetric(horizontal: 50),
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
                      : 'formato <Email> non valida',
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
              saved: (psw) => _pswdCtrl.text = psw,
            ),
            CustomInput(
              icon: Icons.lock_outline,
              placeHolder: 'Verifica Password',
              isPassword: true,
              textController: _verPswCtrl,
              keyboardType: TextInputType.text,
              validator: (vPsw) => (vPsw.toString().trim().isNotEmpty &&
                      vPsw.toString().length >= 8)
                  ? null
                  : '<Password/Verifica> non coincidono',
              saved: (vPsw) => _verPswCtrl.text = vPsw,
            ),
            ButtonBlue(
                text: 'Registrarsi',
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    _authService
                        .registrandoSignUp(_emailCtrl.text, _pswdCtrl.text)
                        .then((userExist) {
                      if (userExist != null) {
                        Navigator.of(context).pushReplacementNamed('login');
                      }
                    }).catchError((error) {
                      Fluttertoast.showToast(
                          msg:
                              'Problemi durante la registrazione\nRiprova più tarde...',
                          backgroundColor: Colors.red[200],
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          textColor: Colors.white,
                          toastLength: Toast.LENGTH_LONG);
                    });
                    //}
                  }
                }),
          ],
        ),
      ),
    );
  }
}
