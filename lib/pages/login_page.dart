import 'package:appvocado/components/my_button.dart';
import 'package:appvocado/components/my_textfield.dart';
import 'package:appvocado/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controles de editores de texto
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //mensaje de error
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 113, 119, 125),
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

  //metodo de inicio de sesion
  void signUserIn() async {
    //mostrar circulo de carga
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    //inicio de sesion auth firebase

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //cerrar el circulo de carga
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //cerrar el circulo de carga
      Navigator.pop(context);
      //mensaje de error
      showErrorMessage(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      height: 50,
                    ),
                    //logo
                    const Icon(
                      Icons.account_circle_outlined,
                      size: 100,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //Bienvenido te extrañabamos
                    const Text(
                      'BIENVENIDO',
                      style: TextStyle(
                        color: Color.fromARGB(255, 246, 246, 246),
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

                    //olvidaste tu contraseña
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'olvidaste tu contraseña?',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 25,
                    ),

                    //inicio de sesion boton
                    MyButton(text: 'Iniciar Sesion', onTap: signUserIn),

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
                              thickness: 1.0,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'o continua con',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 16),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1.0,
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
                          'no estas registrado?',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'registrate ahora',
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
