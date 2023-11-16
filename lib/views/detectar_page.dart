import 'dart:io';
import 'package:appvocado/components/colores.dart';
import 'package:appvocado/views/resultado_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DetectarPage extends StatefulWidget {
  const DetectarPage({super.key});

  @override
  State<DetectarPage> createState() => _DetectarPageState();
}

class _DetectarPageState extends State<DetectarPage> {
  late ImagePicker imagePicker;
  File? _image;
  String result = 'Los resultados se mostraran aquí';
  bool showResultButton = false;

  late ImageLabeler imageLabeler;
  late ImageLabeler imageLabeler2;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
    //final ImageLabelerOptions options =
    //    ImageLabelerOptions(confidenceThreshold: 0.5);
    //imageLabeler = ImageLabeler(options: options);
    loadModel();
  }

  loadModel() async {
    final modelPath = await getModelPath('assets/ml/model.tflite');
    final options = LocalLabelerOptions(
      confidenceThreshold: 0.5,
      modelPath: modelPath,
    );
    imageLabeler = ImageLabeler(options: options);

    final modelPath2 = await getModelPath('assets/ml/model_metadata.tflite');
    final options2 = LocalLabelerOptions(
      confidenceThreshold: 0.5,
      modelPath: modelPath2,
    );
    imageLabeler2 = ImageLabeler(options: options2);
  }

  @override
  void dispose() {
    super.dispose();
  }

  //TODO capture image using camera
  _imageFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    _image = File(pickedFile!.path);
    setState(() {
      _image;
      doImageLabeling();
    });
  }

  //TODO choose image using gallery
  _imageFromGallery() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        doImageLabeling();
      });
    }
  }

  doImageLabeling() async {
    InputImage inputImage = InputImage.fromFile(_image!);

    // Procesar la imagen con el primer modelo
    final List<ImageLabel> labels1 =
        await imageLabeler2.processImage(inputImage);

    result = '';

    // Verificar si el primer modelo detecta "aguacate"
    bool isAguacateDetected =
        labels1.any((label) => label.label == '0 Aguacate');

    if (isAguacateDetected) {
      // Si el primer modelo detecta "aguacate", procesar la imagen con el segundo modelo
      final List<ImageLabel> labels2 =
          await imageLabeler.processImage(inputImage);

      for (ImageLabel label in labels2) {
        final String text = label.label;
        // ignore: unused_local_variable
        final int index = label.index;
        final double confidence = label.confidence;
        result += text;
      }
    } else {
      // Si el primer modelo no detecta "aguacate", mostrar un mensaje en el resultado
      result = 'No es un Aguacate';
    }

    setState(() {
      result;
      showResultButton = isAguacateDetected;
    });
  }

  Future<String> getModelPath(String asset) async {
    final path = '${(await getApplicationSupportDirectory()).path}/$asset';
    await Directory(dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(asset);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('Deteccion'),
        backgroundColor: gradientStartColor,
      ),
      body: Container(
        decoration: BoxDecoration(color: gradientEndColor),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.all(0),
                ),
                onPressed: _imageFromGallery,
                onLongPress: _imageFromCamera,
                child: Container(
                  width: 335,
                  height: 495,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(148, 255, 255,
                        255), // Cambia el color de fondo según tus preferencias
                    border: Border.all(
                      color: Colors.green,
                    ), // Agrega un borde
                  ),
                  child: Center(
                    child: _image != null
                        ? Image.file(
                            _image!,
                            width: 335,
                            height: 495,
                            fit: BoxFit
                                .cover, // Usa "cover" para rellenar el contenedor
                          )
                        : const Icon(
                            Icons.camera_alt,
                            color: Colors.black,
                            size: 100,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Espacio entre el botón y el texto
              Text(
                result,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AnimatedOpacity(
                opacity: showResultButton ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultPage(result: result),
                        ),
                      );
                    },
                    child: const Text("Mas Información")),
              )
            ],
          ),
        ),
      ),
      backgroundColor: gradientEndColor,
    );
  }
}
