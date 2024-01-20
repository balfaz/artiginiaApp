import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String titulo;
  final String subtitle;

  const Labels(
      {Key? key, required this.ruta, required this.titulo, this.subtitle = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(
            titulo,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 15.0,
                fontWeight: FontWeight.w300),
          ),
          const SizedBox(
            height: 8.0,
          ),
          //GestureDetector()
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, ruta);
            },
            child: Text(
              subtitle,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
