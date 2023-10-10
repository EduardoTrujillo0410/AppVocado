import "package:appvocado/components/my_textfield.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class forgotPasswordPage extends StatefulWidget {
  const forgotPasswordPage({super.key});

  @override
  State<forgotPasswordPage> createState() => _forgotPasswordPageState();
}

class _forgotPasswordPageState extends State<forgotPasswordPage> {
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
        backgroundColor: Colors.deepPurple,
        elevation: 5,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'digita tu Email y te enviaremos un link para reestablecer tu contraseña',
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
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: passwordReset,
            color: Colors.deepPurple[200],
            child: const Text('Reestablecer Contraseña'),
          )
        ],
      ),
    );
  }
}
