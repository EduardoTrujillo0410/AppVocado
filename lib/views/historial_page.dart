import 'package:appvocado/components/colores.dart';
import 'package:flutter/material.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        backgroundColor: gradientStartColor,
      ),
      backgroundColor: gradientEndColor,
      body: const Center(
        child: Text('Contenido de la página de historial'),
      ),
    );
  }
}
