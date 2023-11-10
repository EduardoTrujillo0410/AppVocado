import 'package:appvocado/components/colores.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistorialPage extends StatelessWidget {
  const HistorialPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        backgroundColor: gradientStartColor,
      ),
      backgroundColor: gradientEndColor,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('historial').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var historialEntries = snapshot.data!.docs;
            return ListView.builder(
              itemCount: historialEntries.length,
              itemBuilder: (context, index) {
                var entry =
                    historialEntries[index].data() as Map<String, dynamic>;
                var enfermedad = entry['enfermedad'];
                var fecha = entry['fecha'];

                return ListTile(
                  title: Text(
                    '$enfermedad - $fecha',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetallesHistorialPage(entry),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar los datos del historial'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class DetallesHistorialPage extends StatelessWidget {
  final Map<String, dynamic> entry;

  DetallesHistorialPage(this.entry);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Historial'),
        backgroundColor: gradientStartColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Enfermedad: ${entry['enfermedad']}'),
            Text('Fecha: ${entry['fecha']}'),
            // Agrega más campos según necesites
          ],
        ),
      ),
    );
  }
}
