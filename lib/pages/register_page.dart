import 'package:appvocado/components/my_button.dart';
import 'package:appvocado/components/my_textfield.dart';
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
  bool isRegisterButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateFields);
    passwordController.addListener(_validateFields);
    confirmPasswordController.addListener(_validateFields);
  }

  void _validateFields() {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    bool isEmailValid = email.isNotEmpty && email == email.toLowerCase();
    bool isPasswordValid = password.isNotEmpty &&
        password.contains(RegExp(r'[A-Z]')) &&
        password.contains(RegExp(r'[a-z]')) &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*()]'));
    bool arePasswordsMatching = password == confirmPassword;

    setState(() {
      isRegisterButtonEnabled =
          isEmailValid && isPasswordValid && arePasswordsMatching;
    });
  }

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
    if (isRegisterButtonEnabled) {
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
          Navigator.of(context).pop();
          await saveUserDataToFirestore(user);
        } else {
          Navigator.of(context).pop();
          print('User is null. Cannot save to Firestore.');
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 174, 206, 175),
      body: Container(
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
                    const Icon(
                      Icons.account_circle_outlined,
                      size: 100,
                      color: Colors.white,
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    //Bienvenido te extrañabamos
                    const Text(
                      'Creemos una cuenta para tí!',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    //correo electronico textfield
                    MyTextField(
                      controller: emailController,
                      hintText: 'Correo Electronico',
                      obscureText: false,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //contraseña textfield
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Contraseña',
                      obscureText: true,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //confirmar contraseña textfield
                    MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirmar Contraseña',
                      obscureText: true,
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    //inicio de sesion boton
                    MyButton(
                      text: 'Registrarse',
                      onTap: isRegisterButtonEnabled ? signUserUp : null,
                    ),

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
                        const Text(
                          'ya tienes una cuenta?',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Inicia Sesion ahora',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
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
    );
  }
}
