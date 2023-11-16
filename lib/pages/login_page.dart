import 'package:appvocado/components/my_button.dart';
import 'package:appvocado/components/my_textfield.dart';
import 'package:appvocado/pages/reset_password_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();

  static signUserIn(String s, String t) {}
}

class _LoginPageState extends State<LoginPage> {
  //controles de editores de texto
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //cerrar el circulo de carga
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      //mensaje de error
      showErrorMessage(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        height: 50,
                      ),
                      //logo
                      Icon(
                        Icons.account_circle_outlined,
                        size: 100,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: const Offset(2.0, 2.0), //position of shadow
                            blurRadius: 4.0, //blur intensity of shadow
                            color: Colors.black.withOpacity(
                                0.9), //color of shadow with opacity
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      Text(
                        'BIENVENIDO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset:
                                  const Offset(2.0, 2.0), //position of shadow
                              blurRadius: 4.0, //blur intensity of shadow
                              color: Colors.black.withOpacity(
                                  0.9), //color of shadow with opacity
                            ),
                          ],
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
                        iconos: const Icon(Icons.email),
                        validador2: (value) {
                          if (value!.isEmpty) {
                            return 'Este campo es obligatorio';
                          }
                          if (value != value.toLowerCase()) {
                            return 'Deben ser todas minusculas';
                          }
                          if (value.length > 30) {
                            return 'El correo tiene que ser menor de 30 caracteres';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      //contraseña textfield
                      MyTextField(
                        controller: passwordController,
                        hintText: 'Contraseña',
                        obscureText: true,
                        iconos: const Icon(Icons.password),
                        validador2: (value) {
                          if (value!.isEmpty) {
                            return 'Este campo es obligatorio';
                          }
                          if (value.length < 8 || value.length > 16) {
                            return 'La contraseña debe tener entre 8 y 16 caracteres';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      //olvidaste tu contraseña
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: Text(
                                'Olvidaste tu Contraseña?',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  shadows: [
                                    Shadow(
                                      offset: const Offset(
                                          2.0, 2.0), //position of shadow
                                      blurRadius:
                                          1.0, //blur intensity of shadow
                                      color: Colors.black.withOpacity(
                                          0.9), //color of shadow with opacity
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const ForgotPasswordPage();
                                  },
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      //inicio de sesion boton
                      MyButton(
                        text: 'Iniciar Sesión',
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            signUserIn();
                          }
                        },
                      ),

                      const SizedBox(
                        height: 35,
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
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                '',
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
                        height: 75,
                      ),

                      //no estas registrado? resgistrate ahora
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'no estas registrado?',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(2.0, 2.0),
                                    blurRadius: 1.0,
                                    color: const Color.fromARGB(255, 0, 0, 0)
                                        .withOpacity(0.9),
                                  )
                                ]),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: widget.onTap,
                            child: Text(
                              'Regístrate Ahora',
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
