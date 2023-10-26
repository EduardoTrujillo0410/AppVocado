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
      String displayName = displayNameController.text;
      String email = emailController.text;
      String newPassword = newPasswordController.text;

      // Obtén el usuario actualmente autenticado
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Map<String, dynamic> updateData = {};

        if (displayName.isNotEmpty) {
          updateData['displayName'] = displayName;
          await user.updateDisplayName(displayName);
        }
        if (email.isNotEmpty) {
          updateData['email'] = email;
          await user.updateEmail(email);
        }
        if (newPassword.isNotEmpty) {
          await user.updatePassword(newPassword);
        }

        // Accede a la colección "usuarios" y actualiza el documento con el UID del usuario
        String? userId = user.uid;
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(userId)
            .update(updateData);

        // Mostrar un mensaje de éxito
        displayMessage('Datos actualizados');

        // Limpia los TextFields después de guardar los datos
        displayNameController.clear();
        emailController.clear();
        newPasswordController.clear();
      } else {
        print('El usuario no está autenticado.');
      }
    } catch (error) {
      // Maneja los errores, muestra un diálogo de error, etc.
      print('Error al actualizar datos: $error');
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [gradientStartColor, gradientEndColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.3, 0.7]),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Actualiza tus datos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
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
      ),
    );
  }
}
