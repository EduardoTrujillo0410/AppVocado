import 'package:appvocado/components/colores.dart';
import 'package:appvocado/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ActualizarPage extends StatefulWidget {
  @override
  State<ActualizarPage> createState() => _ActualizarPageState();
}

class _ActualizarPageState extends State<ActualizarPage> {
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  Future<void> actualizarDatos() async {
    try {
      // Accede a Firebase Firestore y actualiza los datos según sea necesario
      String displayName = displayNameController.text;
      String email = emailController.text;
      String newPassword = newPasswordController.text;

      // Obtén el ID del usuario actual
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        // Accede a la colección "usuarios" y actualiza el documento con el UID del usuario
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(userId)
            .update({
          'displayName': displayName,
          'email': email,
          'password': newPassword,
        });

        // Mostrar un mensaje de éxito o redireccionar a otra pantalla, según sea necesario
        // ...
        displayMessage('datos actualizados');
      } else {
        print('El usuario no está autenticado.');
      }
    } catch (error) {
      // Maneja los errores, muestra un diálogo de error, etc.
      print('Error al actualizar datos: $error');
      // ...
    }
  }

  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradientEndColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyTextField(
              controller: displayNameController,
              hintText: 'Username',
              obscureText: false,
            ),
            const SizedBox(height: 20),
            MyTextField(
              controller: emailController,
              hintText: 'Correo Electronico',
              obscureText: false,
            ),
            const SizedBox(height: 20),
            MyTextField(
              controller: newPasswordController,
              hintText: 'Contraseña',
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: actualizarDatos,
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}
