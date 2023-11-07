import 'package:appvocado/components/colores.dart';
import 'package:appvocado/components/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ActualizarPage extends StatefulWidget {
  const ActualizarPage({super.key});

  @override
  State<ActualizarPage> createState() => _ActualizarPageState();
}

class _ActualizarPageState extends State<ActualizarPage> {
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
        displayMessage('El usuario no está autenticado.');
      }
    } catch (error) {
      // Maneja los errores, muestra un diálogo de error, etc.
      displayMessage('Error al actualizar datos: $error');
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
      body: Form(
        key: _formKey,
        child: Container(
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
                  iconos: const Icon(Icons.person),
                  validador2: (value) {
                    if (value!.isEmpty) {
                      return null;
                    }
                    if (value.length > 10) {
                      return "el username tiene que ser menor a 10 caracteres";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: emailController,
                  hintText: 'Correo Electronico',
                  obscureText: false,
                  iconos: const Icon(Icons.email),
                  validador2: (value) {
                    if (value!.isEmpty) {
                      return null;
                    }
                    if (value != value.toLowerCase()) {
                      return 'deben ser todas minusculas';
                    }
                    if (value.length > 30) {
                      return 'El correo tiene que ser menos de 30 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: newPasswordController,
                  hintText: 'Contraseña',
                  obscureText: true,
                  iconos: const Icon(Icons.password),
                  validador2: (value) {
                    if (value!.isEmpty) {
                      return null;
                    }
                    if (value.length < 8 || value.length > 16) {
                      return 'La contraseña debe tener entre 8 y 16 caracteres';
                    }
                    // Verifica si la contraseña contiene al menos una minúscula, una mayúscula,
                    // un carácter especial y un número.
                    if (!RegExp(
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%^&*()_+.])([A-Za-z0-9!@#\$%^&*()_+.]+)$')
                        .hasMatch(value)) {
                      return 'La contraseña debe contener al menos una minúscula, una mayúscula, un número y un carácter especial';
                    }
                    return null; // No hay errores de validación
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      actualizarDatos();
                    }
                  },
                  child: const Text('Actualizar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
