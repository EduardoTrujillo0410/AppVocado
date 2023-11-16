import "package:appvocado/components/colores.dart";
import "package:appvocado/components/my_textfield.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text('se ha enviado el link a tu correo'),
              );
            });
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: gradientStartColor,
        elevation: 5,
        title: const Text('Restablecer Contraseña'),
      ),
      backgroundColor: gradientEndColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Digita tu Email y te enviaremos un link para restablecer tu contraseña',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
            controller: emailController,
            hintText: 'Correo Electronico',
            obscureText: false,
            iconos: const Icon(Icons.email),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: passwordReset,
            child: const Text('Restablecer Contraseña'),
          )
        ],
      ),
    );
  }
}
