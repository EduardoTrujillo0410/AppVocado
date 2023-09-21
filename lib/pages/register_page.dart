import 'package:appvocado/components/my_button.dart';
import 'package:appvocado/components/my_textfield.dart';
import 'package:appvocado/components/square_tile.dart';
import 'package:appvocado/pages/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  //mensaje de error
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 31, 71, 153),
          title: Center(
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
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
      //pop loading circle
      Navigator.pop(context);
      //mostrar error al usuario
      displayMessage("las contraseñas no coinciden");
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (context.mounted) Navigator.pop(context);
      displayMessage("Registro exitoso");
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      //mostrar error al usuario
      displayMessage(e.code);
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
      backgroundColor: Color.fromARGB(255, 174, 206, 175),
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
                      height: 25,
                    ),

                    //inicio de sesion boton
                    MyButton(text: 'Registrarse', onTap: signUserUp),

                    const SizedBox(
                      height: 25,
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
                              'o continua con',
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
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SquareTile(imagePath: 'lib/images/google.png')
                      ],
                    ),

                    const SizedBox(
                      height: 25,
                    ),

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
