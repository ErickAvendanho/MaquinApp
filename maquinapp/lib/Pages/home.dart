import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/registerPage.dart';
import 'dart:math' as math;

import 'package:maquinapp/Pages/singmenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDD835),
        title: Image.asset(
          'assets/images/logomaquina.png',
          height: size.height * 0.15,
        ),
        centerTitle: true,
      ),
      drawer: _drawerMaquinapp(size),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }

  Drawer _drawerMaquinapp(Size size) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0XFF3B3A38),
              ),
              padding: const EdgeInsets.only(top: 40, left: 20, bottom: 30),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(1.0),
                    radius: 50,
                    child: const Text(
                      'P',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        const Text(
                          'Pablo Pérez',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                        Wrap(
                          children: const [
                            Icon(
                              Icons.star_rounded,
                              color: Colors.white,
                            ),
                            Icon(
                              Icons.star_rounded,
                              color: Colors.white,
                            ),
                            Icon(
                              Icons.star_rounded,
                              color: Colors.white,
                            ),
                            Icon(
                              Icons.star_outline_rounded,
                              color: Colors.white,
                            ),
                            Icon(
                              Icons.star_outline_rounded,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {},
              title: const Text('Mi perfil'),
            ),
            ListTile(
              onTap: () {},
              title: const Text('Mis solicitudes'),
            ),
            ListTile(
              onTap: () {},
              title: const Text('Subir nuevo trabajo'),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const SignPage(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              title: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
