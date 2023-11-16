import 'package:appvocado/components/colores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final String result;

  const ResultPage({Key? key, required this.result}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Future<void> guardarEnHistorial() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        CollectionReference historialCollection =
            FirebaseFirestore.instance.collection('Historial');
        DocumentReference userDocument = historialCollection.doc(userId);

        // Obtener referencia a la subcolección 'Historiales' dentro del documento del usuario
        CollectionReference historialesSubcollection =
            userDocument.collection('Historiales');

        DateTime now = DateTime.now();

        String enfermedadNombre = widget.result;
        String enfermedadDescripcion = "";
        String enfermedadCausa = "";
        String enfermedadTratamiento = "";

        QuerySnapshot enfermedadSnapshot = await FirebaseFirestore.instance
            .collection('Enfermedad')
            .where('Nombre', isEqualTo: widget.result)
            .get();

        if (enfermedadSnapshot.docs.isNotEmpty) {
          DocumentSnapshot enfermedadDocument = enfermedadSnapshot.docs.first;
          enfermedadDescripcion = enfermedadDocument['Descripción'] ?? '';
          enfermedadCausa = enfermedadDocument['Causa'] ?? '';
          enfermedadTratamiento = enfermedadDocument['Tratamiento'] ?? '';
        }

        // Guardar la información del historial dentro de la subcolección 'Historiales'
        await historialesSubcollection.add({
          'Fecha': now,
          'Enfermedad': {
            'Nombre': enfermedadNombre,
            'Descripción': enfermedadDescripcion,
            'Causa': enfermedadCausa,
            'Tratamiento': enfermedadTratamiento,
          },
          // Otros campos según sea necesario
        });

        print('Resultado guardado en el historial.');
      } else {
        print('Usuario no autenticado');
      }
    } catch (e) {
      print('Error al guardar en el historial: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultado'),
        backgroundColor: gradientStartColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: gradientEndColor),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*Text(
                  widget.result,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),*/
                // Añadido un espacio entre el texto y la lista
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Enfermedad')
                      .where('Nombre', isEqualTo: widget.result)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        // Ajusta este valor según tus necesidades
                        height: 650,
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            final DocumentSnapshot document =
                                snapshot.data!.docs[index];

                            // Verificar si los campos 'Name' y 'Descripción' existen
                            final name =
                                document['Nombre'] ?? 'Nombre no disponible';
                            final descripcion = document['Descripción'] ??
                                'Descripción no disponible';
                            final causa =
                                document['Causa'] ?? 'Causa no disponible';
                            final tratamiento = document['Tratamiento'] ??
                                'Tratamiento no disponible';

                            return ListTile(
                              title: Text(
                                name.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.yellow,
                                  shadows: [
                                    Shadow(
                                      offset: const Offset(
                                          2.0, 2.0), //position of shadow
                                      blurRadius:
                                          4.0, //blur intensity of shadow
                                      color: Colors.black.withOpacity(
                                          0.9), //color of shadow with opacity
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Descripción:\n $descripcion',
                                    textAlign: TextAlign.justify,
                                  ),
                                  Text(
                                    'Causa:\n $causa',
                                    textAlign: TextAlign.justify,
                                  ),
                                  Text('Tratamiento:\n $tratamiento',
                                      textAlign: TextAlign.justify)
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Text('Error al cargar los datos');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    guardarEnHistorial();
                  },
                  child: Text('Guardar en Historial'),
                )
              ],
            ),
          ),
        ),
      ),
      backgroundColor: gradientEndColor,
    );
  }
}
