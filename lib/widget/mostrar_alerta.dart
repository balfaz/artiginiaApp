import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//TODO: Aggiungere una gif animata per alert

mostrarAlerta(BuildContext context, String titulo, String subtitulo) {
  if (Platform.isAndroid) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(titulo),
        content: Text(subtitulo),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Ok'),
            elevation: 5,
            textColor: Colors.blue,
          )
        ],
      ),
    );
  } else if (Platform.isIOS) {
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text(titulo),
              content: Text(subtitulo),
              actions: [
                CupertinoDialogAction(
                  child: Text('Ok'),
                  isDefaultAction: true,
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ));
  }
}
