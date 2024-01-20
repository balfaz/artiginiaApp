import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {
  final String text;
  final Function onPressed;
  const ButtonBlue({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      //elevation: 2,
      //color: Colors.blue,
      //shape: StadiumBorder(),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
      onPressed: () => onPressed,
    );
  }
}
