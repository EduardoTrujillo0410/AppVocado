import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HistorialPage extends StatefulWidget {
  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  late User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Historial')
            .doc(user?.uid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            var documento = snapshot.data!;
            var historiales = documento.reference.collection('Historiales');

            return StreamBuilder<QuerySnapshot>(
              stream:
                  historiales.orderBy('Fecha', descending: true).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> historialesSnapshot) {
                if (historialesSnapshot.hasData) {
                  return ListView.builder(
                    itemCount: historialesSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var historial = historialesSnapshot.data!.docs[index];
                      var datos = historial.data() as Map<String, dynamic>;
                      var fecha = datos['Fecha'] != null
                          ? (datos['Fecha'] as Timestamp).toDate()
                          : null;
                      var enfermedad = datos['Enfermedad'] != null
                          ? datos['Enfermedad']['Nombre']
                          : 'Sin enfermedad';

                      return ListTile(
                        title: Text('Fecha: $fecha'),
                        subtitle: Text('Enfermedad: $enfermedad'),
                        trailing: ElevatedButton(
                          onPressed: () {
                            _mostrarDetalles(datos);
                          },
                          child: Text('Ver Detalles'),
                        ),
                      );
                    },
                  );
                } else if (historialesSnapshot.hasError) {
                  return Center(
                    child: Text('Error al cargar el historial.'),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar el historial.'),
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

  void _mostrarDetalles(Map<String, dynamic> datos) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles'),
          content: SingleChildScrollView(
            child: Text(
              'Enfermedad: ${datos['Enfermedad']['Nombre']}\n'
              'Causa: ${datos['Enfermedad']['Causa']}\n'
              'Tratamiento: ${datos['Enfermedad']['Tratamiento']}\n',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
