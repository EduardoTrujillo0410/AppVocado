import 'package:appvocado/pages/auth_page.dart';
import 'package:flutter/material.dart';

//importaciones del firebase//
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Forzar la orientación vertical
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
    );
  }
}
