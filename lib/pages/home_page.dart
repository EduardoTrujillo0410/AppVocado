import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;
  Color colorVerde = const Color.fromARGB(217, 32, 187, 50);

  //cerrar sesion metodo
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            decoration: BoxDecoration(
              color: colorVerde,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  title: Text(
                    'Hola: ${user.email}',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Bienevenido',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.white54),
                  ),
                  trailing: IconButton(
                    onPressed: signUserOut,
                    icon: const Icon(Icons.logout),
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
          Container(
            color: colorVerde,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(100),
                ),
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 30,
                children: [
                  itemDashboard(context, 'Detectar',
                      CupertinoIcons.camera_circle_fill, Colors.deepOrange),
                  itemDashboard(
                      context,
                      'Historial',
                      CupertinoIcons.arrow_counterclockwise_circle_fill,
                      Colors.green),
                  itemDashboard(context, 'Acerca de',
                      CupertinoIcons.info_circle_fill, Colors.purple),
                  itemDashboard(context, 'actualizar',
                      CupertinoIcons.person_solid, Colors.brown),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget itemDashboard(
          BuildContext context, title, IconData iconData, Color background) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                color: Theme.of(context).primaryColor.withOpacity(.2),
                spreadRadius: 2,
                blurRadius: 5)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: background,
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      );
}
