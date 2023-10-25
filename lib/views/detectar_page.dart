import 'dart:io';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetectarPage extends StatefulWidget {
  @override
  State<DetectarPage> createState() => _DetectarPageState();
}

class _DetectarPageState extends State<DetectarPage> {
  final FirebaseModelDownloader downloader = FirebaseModelDownloader.instance;
  FirebaseCustomModel? _model;

  final picker = ImagePicker();
  XFile? _image;

  Future<void> _loadModel() async {
    // Descarga el modelo de Firebase ML a tu dispositivo.
    _model = await downloader
        .getModel(
            'appvocado', // Nombre del modelo (ajusta esto a tu nombre de modelo)
            FirebaseModelDownloadType.localModel, // Tipo de modelo
            FirebaseModelDownloadConditions(
              iosAllowsCellularAccess:
                  true, // Permite el uso de datos móviles en iOS
              iosAllowsBackgroundDownloading:
                  false, // Descarga en segundo plano en iOS
              androidChargingRequired: false, // No se requiere carga en Android
              androidWifiRequired: false, // No se requiere Wi-Fi en Android
              androidDeviceIdleRequired:
                  false, // No se requiere el dispositivo en reposo en Android
            ))
        .then((value) => null);
  }

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
            // Muestra un mensaje mientras se carga el modelo.
            FutureBuilder(
              future: _loadModel(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Cargando el modelo...');
                } else if (snapshot.hasError) {
                  return Text('Error al cargar el modelo: ${snapshot.error}');
                } else {
                  return Text('Modelo cargado correctamente');
                }
              },
            ),
            _image == null
                ? const Text('Selecciona o toma una foto del aguacate')
                : Image.file(File(_image!.path)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImageFromCamera,
              child: const Text('Tomar Foto'),
            ),
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: const Text('Cargar desde Galería'),
            ),
            _image == null
                ? Container()
                : ElevatedButton(
                    onPressed: () {
                      // Implementa la lógica de clasificación aquí
                    },
                    child: const Text('Clasificar'),
                  ),
          ],
        ),
      ),
    );
  }
}
