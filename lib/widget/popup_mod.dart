import 'dart:io';

import 'package:flutter/material.dart';

class PopupMod extends StatefulWidget {
  PopupMod({Key? key}) : super(key: key);

  @override
  _PopupModState createState() => _PopupModState();
}

class _PopupModState extends State<PopupMod> {
  var result;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      result = showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('titolo'),
          content: Text('subtitolo'),
          actions: [
            MaterialButton(
              onPressed: () => Navigator.pop(context),
              elevation: 5,
              textColor: Colors.blue,
              child: const Text('Ok'),
            )
          ],
        ),
      );
    }
    return result;
  }
}
