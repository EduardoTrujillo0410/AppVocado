import 'package:appvocado/components/my_button.dart';
import 'package:appvocado/components/my_textfield2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //controles de editores de texto
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  // Crear un GlobalKey para el formulario
  final _formKey = GlobalKey<FormState>();

  //mensaje de error
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 31, 71, 153),
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  Future<void> createHistorialDocument(String uid) async {
    try {
      CollectionReference historialCollection =
          FirebaseFirestore.instance.collection('Historial');

      // Crear un nuevo documento con el UID del usuario como identificador
      await historialCollection.doc(uid).set({
        'usuarioUid': uid,
        // Puedes agregar más campos según tus necesidades
        // Puedes inicializar con un array vacío u otros datos iniciales
      });

      print(
          'Documento en historial creado exitosamente para el usuario con UID: $uid');
    } catch (error) {
      print('Error al crear el documento en historial: $error');
      // Puedes manejar el error según tus necesidades
    }
  }

  Future<void> saveUserDataToFirestore(User user) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usuarios');

    // Obtén información adicional sobre el usuario
    String displayName = user.displayName ?? '';
    String email = user.email ?? '';

    // Guarda la información en Firestore
    await users.doc(user.uid).set({
      'uid': user.uid,
      'displayName': displayName,
      'email': email,
      // Otros campos de usuario que desees almacenar
    });
  }

  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
      ),
    );
  }

  void signUserUp() async {
    //mostrar circulo de carga
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    //asegurar que las contraseñas coincidan
    if (passwordController.text != confirmPasswordController.text) {
      // Ocultar el círculo de carga
      Navigator.of(context).pop();
      // Mostrar error al usuario
      showErrorMessage("Las contraseñas no coinciden");
      return;
    }
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Obtén el usuario a partir del userCredential
      User? user = userCredential.user;

      if (user != null) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        await saveUserDataToFirestore(user);
        await createHistorialDocument(user.uid);
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        showErrorMessage(
            'El Usuario es nulo. No se puede guardar en Firestore.');
      }
      // ignore: use_build_context_synchronously
      if (mounted) Navigator.of(context).pop();
      //displayMessage("Registro exitoso");
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      // ignore: use_build_context_synchronously
      if (mounted) Navigator.of(context).pop();
      //mostrar error al usuario
      showErrorMessage(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 174, 206, 175),
      body: Form(
        key: _formKey,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              //imagen de fondo
              image: AssetImage(
                'lib/images/fondo2.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      //logo
                      Icon(
                        Icons.account_circle_outlined,
                        size: 100,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: const Offset(2.0, 2.0), //position of shadow
                            blurRadius: 1.0, //blur intensity of shadow
                            color: Colors.black.withOpacity(
                                0.99), //color of shadow with opacity
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      //Bienvenido te extrañabamos
                      Text(
                        'Creemos una cuenta para tí!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset:
                                  const Offset(2.0, 2.0), //position of shadow
                              blurRadius: 3.0, //blur intensity of shadow
                              color: Colors.black.withOpacity(
                                  0.99), //color of shadow with opacity
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      //correo electronico textfield
                      MyTextField2(
                        controller: emailController,
                        hintText: 'Correo Electronico',
                        obscureText: false,
                        iconos2: const Icon(Icons.email),
                        validador: (value) {
                          if (value!.isEmpty) {
                            return 'Este campo es obligatorio';
                          }
                          if (value != value.toLowerCase()) {
                            return 'Deben ser todas minusculas';
                          }
                          if (value.length > 30) {
                            return 'El correo tiene que ser menos de 30 caracteres';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      //contraseña textfield
                      MyTextField2(
                        controller: passwordController,
                        hintText: 'Contraseña',
                        obscureText: true,
                        iconos2: const Icon(Icons.password),
                        validador: (value) {
                          if (value!.isEmpty) {
                            return 'La contraseña no puede estar vacía';
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

                      const SizedBox(
                        height: 10,
                      ),

                      //confirmar contraseña textfield
                      MyTextField2(
                        controller: confirmPasswordController,
                        hintText: 'Confirmar Contraseña',
                        obscureText: true,
                        iconos2: const Icon(Icons.password),
                        validador: (value) {
                          if (value!.isEmpty) {
                            return 'La contraseña no puede estar vacía';
                          }

                          if (value.length < 8 || value.length > 16) {
                            return 'La contraseña debe tener entre 8 y 16 caracteres';
                          }

                          // Verifica si la contraseña contiene al menos una minúscula, una mayúscula,
                          // un carácter especial y un número.
                          if (!RegExp(
                                  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%^&*()_+])[A-Za-z0-9!@#\$%^&*()_+]+$')
                              .hasMatch(value)) {
                            return 'La contraseña debe contener al menos una minúscula, una mayúscula, un número y un carácter especial';
                          }

                          return null; // No hay errores de validación
                        },
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      //inicio de sesion boton
                      MyButton(
                          text: 'Registrarse',
                          onTap: () {
                            // Validar el formulario antes de registrar al usuario
                            if (_formKey.currentState!.validate()) {
                              signUserUp();
                            }
                          }),

                      const SizedBox(
                        height: 15,
                      ),

                      //o continua con
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                '',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      //google inicio de sesion

                      //no estas registrado? resgistrate ahora
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ya tienes una cuenta?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              shadows: [
                                Shadow(
                                  offset: const Offset(
                                      2.0, 2.0), //position of shadow
                                  blurRadius: 1.0, //blur intensity of shadow
                                  color: Colors.black.withOpacity(
                                      0.99), //color of shadow with opacity
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              'Inicia Sesión',
                              style: TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(
                                        2.0, 2.0), //position of shadow
                                    blurRadius: 1.0, //blur intensity of shadow
                                    color: Colors.black.withOpacity(
                                        0.99), //color of shadow with opacity
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
