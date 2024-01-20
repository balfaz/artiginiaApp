import 'dart:io';

import 'package:artigian_app/widget/customInputNoIcon.dart';
import 'package:artigian_app/widget/custominput.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum Choosing { Immagine, Documento }

class AllegatiPage extends StatefulWidget {
  AllegatiPage({Key? key}) : super(key: key);

  @override
  _AllegatiPageState createState() => _AllegatiPageState();
}

class _AllegatiPageState extends State<AllegatiPage> {
  TextEditingController titolo = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController descrip = TextEditingController();
  Choosing _tChoose = Choosing.Immagine;
  FontWeight _fontWeight1 = FontWeight.bold;
  FontWeight _fontWeight2 = FontWeight.normal;
  double _fontSize1 = 18.0;
  double _fontSize2 = 16.0;
  File? _imageFile;
  final picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              _options(),
              Divider(),
              _loadImage(),
              Container(
                width: 200,
                height: 200,
                child: _imageFile == null
                    ? Text('Nessuna immagine selezionata')
                    : Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                height: 30.0,
              ),
              _datiAllegato()
            ],
          ),
        ),
      ),
    );
  }

  void _handleRadioValueChanged(Choosing? picked) {
    setState(() {
      _tChoose = picked!;
      if (picked == Choosing.Immagine) {
        _fontWeight1 = FontWeight.w600;
        _fontWeight2 = FontWeight.normal;
        _fontSize1 = 18.0;
        _fontSize2 = 16.0;
      } else {
        _fontWeight1 = FontWeight.normal;
        _fontWeight2 = FontWeight.w600;
        _fontSize1 = 16.0;
        _fontSize2 = 18.0;
      }
    });
  }

  Widget _options() {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Radio(
            value: Choosing.Immagine,
            groupValue: _tChoose,
            onChanged: _handleRadioValueChanged),
        Text(
          'Immagine',
          style: TextStyle(fontSize: _fontSize1, fontWeight: _fontWeight1),
        ),

        SizedBox(
          width: 20.0,
        ),
        Radio(
          value: Choosing.Documento,
          groupValue: _tChoose,
          onChanged: _handleRadioValueChanged,
        ),
        Text(
          'Documento',
          style: TextStyle(fontSize: _fontSize2, fontWeight: _fontWeight2),
        )
        // )
      ],
    );
  }

  _loadImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.grey[300]),
          child: IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: getImageCam,
          ),
        ),
        const SizedBox(
          width: 30.0,
        ),
        Container(
          //color: Colors.grey,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12), color: Colors.grey[300]),
          child: IconButton(
            icon: const Icon(Icons.collections),
            onPressed: getImageGallery,
          ),
        ),
      ],
    );
  }

  Future getImageCam() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('Image not selected');
      }
    });
  }

  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('Image not selected');
      }
    });
  }

  _datiAllegato() {
    return ClipRect(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            customInputNoIcon(context, titolo, 'Titolo', FocusNode()),
            const SizedBox(
              height: 30.0,
            ),
            customInputNoIcon(context, data, 'Data Inserimento', FocusNode()),
            const SizedBox(
              height: 30.0,
            ),
            inputDescrizione(
              context,
              descrip,
              'Descrizione',
              FocusNode(),
            ),
            const SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
