import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maquinapp/Pages/home/home_controller.dart';
import 'package:maquinapp/Pages/home/home_page.dart';
import 'dart:math' as math;

import 'package:maquinapp/Pages/singmenu_page.dart';
import 'package:maquinapp/Pages/src/provider/google_sign_in.dart';
import 'package:maquinapp/models/trabajos_arrendatario.dart';
import 'package:provider/provider.dart';

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
  HomeController _controller = HomeController();

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
      body:  _dashboardMode(size),
    );
  }

  SingleChildScrollView _dashboardMode(Size size) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
        child: FutureBuilder(
          future: _controller.getJobs(),
          builder: (context, data) {
            if (data.hasData) {
              List<TrabajosArrendatario> trabajos =
                  data.data as List<TrabajosArrendatario>;
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: trabajos.isEmpty ? 0 :  trabajos.length>3 ? 3: trabajos.length,
                    itemBuilder: (context, int index) {
                      return WidgetTrabajo(
                        size: size,
                        title: trabajos[index].titulo.toString(),
                        fecha: trabajos[index].fecha.toString(),
                        descripcion: trabajos[index].descripcion.toString(),
                        categoria: trabajos[index].tipo.toString(),
                        cliente: trabajos[index].usuario.toString(),
                        distancia: '3.29 KM',
                        costo: trabajos[index].precio.toString(),
                        img: trabajos[index].foto.toString(),
                        uid: trabajos[index].uid.toString(),
                        isLogued: false
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
              padding: const EdgeInsets.only(top: 40, left: 20, bottom: 30),
              child: Column(
                children: [
                  Image.asset('image.assets/logomaquina.png'),
                  const Text('Bienvenido'),
                  ],
                ),
              ),
            ListTile(
              leading: const Icon(
                Icons.supervisor_account_rounded,
                color: Color(0XFF3B3A38),
              ),
             onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignPage())),              
             title: const Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
