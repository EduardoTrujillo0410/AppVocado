import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetectarPage extends StatefulWidget {
  @override
  State<DetectarPage> createState() => _DetectarPageState();
}

class _DetectarPageState extends State<DetectarPage> {
  final picker = ImagePicker();
  XFile? _image;

  void _getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  void _getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página de Detectar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('Selecciona o toma una foto del aguacate')
                : Image.file(File(_image!.path)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImageFromCamera,
              child: Text('Tomar Foto'),
            ),
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: Text('Cargar desde Galería'),
            ),
            _image == null
                ? Container()
                : ElevatedButton(
                    onPressed: () {
                      // Implementa la lógica de clasificación aquí
                    },
                    child: Text('Clasificar'),
                  ),
          ],
        ),
      ),
    );
  }
}
