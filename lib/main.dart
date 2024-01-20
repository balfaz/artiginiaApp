//TODO: Iniziare con SplashPage che controlli
// stato DB, e altro

import 'package:artigian_app/repositories/dbhelpers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:artigian_app/routes/routes.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DBHelper _db = DBHelper.instance;
  await _db.initDB();
  //await Firebase.initializeApp(); //inizializzare TEMPORANEAMENTE qui */
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'artigianAPP',
      initialRoute: 'listaCantieri',
      //initialRoute: 'ListaCantieriPage',
      routes: appRoutes,
    );
  }
}
