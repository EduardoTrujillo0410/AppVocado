import 'package:appvocado/views/acerca_de_page.dart';
import 'package:appvocado/views/detectar_page.dart';
import 'package:appvocado/views/historial_page.dart';
import 'package:flutter/material.dart';

class DetectarCard extends StatelessWidget {
  const DetectarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9.0,
      color: const Color.fromARGB(255, 231, 210, 140),
      shadowColor: const Color.fromARGB(255, 255, 60, 0),
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            width: double
                .infinity, // La imagen ocupa toda la anchura de la tarjeta
            height: MediaQuery.of(context).size.height *
                0.40, // Ajusta la altura según lo que necesites
            child: Image.asset(
              'lib/images/detectar.jpeg', // Ruta de la imagen
              fit: BoxFit.cover, // Ajusta la imagen dentro del contenedor
            ),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetectarPage()));
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: Colors.green, // Color de fondo del botón
              foregroundColor: Colors.white, // Color del texto del botón
              shadowColor: Colors.red, // Color de la sombra
              textStyle: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: const Text(
                'Detectar',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HistorialCard extends StatelessWidget {
  const HistorialCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9.0,
      color: Color.fromARGB(255, 231, 210, 140),
      shadowColor: Color.fromARGB(255, 255, 115, 0),
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            width: double
                .infinity, // La imagen ocupa toda la anchura de la tarjeta
            height: MediaQuery.of(context).size.height *
                0.40, // Ajusta la altura según lo que necesites
            child: Image.asset(
              'lib/images/Historial.jpeg', // Ruta de la imagen
              fit: BoxFit.cover, // Ajusta la imagen dentro del contenedor
            ),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HistorialPage()));
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: Colors.green, // Color de fondo del botón
              foregroundColor: Colors.white, // Color del texto del botón
              shadowColor: Colors.red, // Color de la sombra
              textStyle: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: const Text(
                'Historial',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AcercaDeCard extends StatelessWidget {
  const AcercaDeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9.0,
      color: Color.fromARGB(255, 231, 210, 140),
      shadowColor: const Color.fromARGB(255, 232, 56, 3),
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            width: double
                .infinity, // La imagen ocupa toda la anchura de la tarjeta
            height: MediaQuery.of(context).size.height *
                0.40, // Ajusta la altura según lo que necesites
            child: Image.asset(
              'lib/images/acerca_de.jpeg', // Ruta de la imagen
              fit: BoxFit.cover, // Ajusta la imagen dentro del contenedor
            ),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AcercaDePage()));
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: Colors.green, // Color de fondo del botón
              foregroundColor: Colors.white, // Color del texto del botón
              shadowColor: Colors.red, // Color de la sombra
              textStyle: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: const Text(
                'Acerca de',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
