import 'package:appvocado/pages/home_page.dart';
import 'package:appvocado/pages/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //el usuario esta logeado
          if (snapshot.hasData) {
            return const HomePage();
          }
          //el usuario no esta logeado
          else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
