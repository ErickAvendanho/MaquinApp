import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/home/home_controller.dart';
import 'dart:math' as math;

import 'package:maquinapp/Pages/singmenu_page.dart';
import 'package:maquinapp/models/trabajos_arrendatarios.dart';

import '../src/search_list_page.dart';
import 'components/widget_trabajo.dart';

class HomePageSignIn extends StatefulWidget {
  const HomePageSignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageSignIn> createState() => _HomePageSignInState();
}

class _HomePageSignInState extends State<HomePageSignIn> {
  final User? user = FirebaseAuth.instance.currentUser;
  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFFDD835),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF3B3A38),
        title: const Text(
          'MAQUINAPP',
          style: TextStyle(
            color: Color(0xFFFDD835),
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchList(),
                ),
              );
            },
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: _drawerMaquinApp(context),
      body: _dashboardMode(size),
    );
  }

  SingleChildScrollView _dashboardMode(Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: FutureBuilder(
          future: _controller.getJobsAndCheckStatusUser(),
          builder: (context, data) {
            if (data.hasData) {
              List<TrabajosArrendatarios> trabajos =
                  data.data as List<TrabajosArrendatarios>;
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: trabajos.isEmpty ? 0 : trabajos.length,
                    itemBuilder: (context, int index) {
                      return WidgetTrabajo(
                        size: size,
                        trabajo: trabajos[index],
                        isLogued: false,
                        isCurrentUserInactive: _controller.isUserInactive,
                        isInCrud: false
                      );
                    },
                  ),
                ],
              );
            } else {
              return Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: CircularProgressIndicator(
                      color: Color(0XFF3B3A38),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Drawer _drawerMaquinApp(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0XFF3B3A38),
              ),
              padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
              child: Column(
                children: [
                  Image.asset('assets/images/maquinapp.png'),
                  const Text(
                    'Bienvenido',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.supervisor_account_rounded,
                color: Color(0XFF3B3A38),
              ),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignPage())),
              title: const Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
