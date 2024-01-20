import 'package:flutter/material.dart';

class LogoApp extends StatelessWidget {
  final String titolo;
  const LogoApp({Key? key, required this.titolo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200.0,
        margin: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            const Image(
              image: AssetImage('assets/tag-logo.png'),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              titolo,
              style: const TextStyle(fontSize: 30.0),
            )
          ],
        ),
      ),
    );
  }
}
