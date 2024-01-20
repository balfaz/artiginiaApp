import 'package:flutter/material.dart';

Widget customInputNoIcon(BuildContext context, TextEditingController ctrl,
    String testo, FocusNode focus) {
  return Container(
      alignment: Alignment.centerRight,
      height: 42.0,
      padding: EdgeInsets.only(left: 3.0),
      margin: EdgeInsets.only(left: 2.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0, 5),
                blurRadius: 5.0)
          ]),
      child: TextField(
        textAlignVertical: TextAlignVertical.top,
        //textAlign: TextAlign.end,
        controller: ctrl,
        autocorrect: false,
        focusNode: focus,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: testo),
      ));
}

Widget inputDescrizione(BuildContext context, TextEditingController ctrl,
    String testo, FocusNode focus) {
  return Container(
      height: 100.0,
      padding: EdgeInsets.only(left: 3.0),
      margin: EdgeInsets.only(left: 2.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0, 5),
                blurRadius: 5.0)
          ]),
      child: TextField(
        textAlignVertical: TextAlignVertical.top,
        controller: ctrl,
        autocorrect: false,
        maxLines: 4,
        focusNode: focus,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: testo),
      ));
}
