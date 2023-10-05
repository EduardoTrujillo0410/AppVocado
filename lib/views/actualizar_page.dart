import 'package:appvocado/components/colores.dart';
import 'package:flutter/material.dart';

class ActualizarPage extends StatefulWidget {
  @override
  State<ActualizarPage> createState() => _ActualizarPageState();
}

class _ActualizarPageState extends State<ActualizarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradientEndColor,
      body: Center(
        child: Text('Contenido de la página de Actualizar'),
      ),
    );
  }
}
