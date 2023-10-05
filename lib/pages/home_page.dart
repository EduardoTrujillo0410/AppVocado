import 'package:appvocado/components/colores.dart';
import 'package:appvocado/views/actualizar_page.dart';
import 'package:appvocado/views/pagina_principal.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [const paginaPrincipal(), ActualizarPage()];

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle:
            const TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 14),
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            label: 'Inicio',
            backgroundColor: navigationColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.person,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            label: 'Actualizar',
            backgroundColor: navigationColor,
          )
        ],
      ),
    );
  }
}
