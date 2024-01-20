import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//TODO: Aggiungere una gif animata per DialogBox

enum DialogAction { annulla, ok }

class Dialogs {
  static Future<DialogAction> mostrartDialogBox(
      {BuildContext? context,
      String? titulo,
      String? subtitulo,
      String? btnNO,
      String? btnSi}) async {
    var action;

    if (Platform.isAndroid) {
      action = await showDialog(
        context: context!,
        builder: (BuildContext context) => AlertDialog(
          title: Text(titulo!),
          content: Text(subtitulo!),
          actions: [
            MaterialButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.annulla),
              elevation: 5,
              textColor: Colors.blue,
              child: Text(btnNO!),
            ),
            MaterialButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.ok),
              //=> Navigator.pop(context),
              elevation: 5,
              textColor: Colors.blue,
              child: Text(btnSi!),
            )
          ],
        ),
      );
    } else if (Platform.isIOS) {
      action = await showCupertinoDialog(
          context: context!,
          builder: (_) => CupertinoAlertDialog(
                title: Text(titulo!),
                content: Text(subtitulo!),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () =>
                        Navigator.of(context).pop(DialogAction.annulla),
                    child: Text(btnNO!),
                  ),
                  CupertinoDialogAction(
                    child: Text(btnSi!),
                    //isDefaultAction: true,
                    onPressed: () => Navigator.of(context).pop(DialogAction.ok),
                  )
                ],
              ));
    }
    return (action != null) ? action : DialogAction.annulla;
  }
}
