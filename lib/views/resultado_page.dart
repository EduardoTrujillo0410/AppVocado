import 'package:appvocado/components/colores.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final String result;

  const ResultPage({super.key, required this.result});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado'),
        backgroundColor: gradientStartColor,
      ),
      body: Container(
        decoration: BoxDecoration(color: gradientEndColor),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.result,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Muestra aquí la información de tu base de datos.
              // Puedes utilizar FutureBuilder u otro método para cargar los datos.
            ],
          ),
        ),
      ),
      backgroundColor: gradientEndColor,
    );
  }
}
