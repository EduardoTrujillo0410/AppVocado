import 'package:appvocado/components/colores.dart';
import 'package:appvocado/components/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

// ignore: must_be_immutable, camel_case_types
class paginaPrincipal extends StatefulWidget {
  const paginaPrincipal({super.key});

  @override
  State<paginaPrincipal> createState() => _paginaPrincipalState();
}

// ignore: camel_case_types
class _paginaPrincipalState extends State<paginaPrincipal> {
  int selectedIndex = 0;

  final List<Widget> cards = [
    const DetectarCard(),
    const HistorialCard(),
    const AcercaDeCard(),
  ];

  final user = FirebaseAuth.instance.currentUser!;

  Color colorVerde = const Color.fromARGB(217, 32, 187, 50);

  //cerrar sesion metodo
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradientEndColor,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [gradientStartColor, gradientEndColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.3, 0.7])),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Hola: \n${user.displayName}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: Colors.white),
                          ),
                          Text(
                            'Bienvenido',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: signUserOut,
                        icon: const Icon(Icons.logout),
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: 500,
                    child: Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return cards[index];
                      },
                      itemWidth: MediaQuery.of(context).size.width - 1 * 70,
                      itemHeight: 700,
                      itemCount: cards.length,
                      layout: SwiperLayout.STACK,
                      pagination: const SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                              color: Colors.grey,
                              activeSize: 10,
                              space: 10,
                              size: 5)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
