import 'package:artigian_app/ui/allegati_page.dart';
import 'package:artigian_app/ui/calendar.dart';
import 'package:artigian_app/ui/materiali_cantiere_page.dart';
import 'package:artigian_app/ui/cantiere_page.dart';
import 'package:artigian_app/ui/google_sign.dart';
import 'package:artigian_app/ui/home_page.dart';
import 'package:artigian_app/ui/lista_cantieri.dart';
import 'package:artigian_app/ui/login_page.dart';
import 'package:artigian_app/ui/registra_page.dart';
import 'package:artigian_app/ui/splash_page.dart';
import 'package:artigian_app/widget/dialog_resetpassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  "splash": (_) => SplashPage(),
  "login": (_) => LoginPage(),
  "reset": (_) => DialogResetPassword(),
  "home": (_) => HomePage(),
  "calendar": (_) => CalendarPage(),
  "listaCantieri": (_) => ListaCantieriPage(),
  "cantiere": (_) => CantierePage(),
  "materiali": (_) => MaterialiCantierePage(),
  "register": (_) => RegisterPage(),
  "signin": (_) => GoogleSignPage(),
  "allegati": (_) => AllegatiPage(),
};
