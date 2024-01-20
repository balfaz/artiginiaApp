import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeHolder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final int maxLines;
  final bool isPassword;
  final FocusNode? isFocus;
  final Function? validator;
  final Function? saved;
  //final String errorMsg;

  const CustomInput(
      {Key? key,
      required this.icon,
      required this.placeHolder,
      required this.textController,
      this.keyboardType = TextInputType.text,
      this.isPassword = false,
      this.maxLines = 1,
      this.isFocus,
      this.validator,
      this.saved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(
            top: 4.0, left: 5.0, right: 20.0, bottom: 2.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, 5),
                  blurRadius: 5.0)
            ]),
        child: TextFormField(
          validator: validator as String? Function(String?)?,
          textAlignVertical: TextAlignVertical.top,
          controller: textController,
          autocorrect: false,
          keyboardType: keyboardType,
          obscureText: isPassword,
          maxLines: maxLines,
          focusNode: isFocus,
          onSaved: saved as void Function(String?)?,
          decoration: InputDecoration(
              prefixIcon: Icon(icon),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: placeHolder),
        ));
  }
}
