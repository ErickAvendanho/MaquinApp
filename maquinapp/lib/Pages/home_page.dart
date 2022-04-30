import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:maquinapp/Pages/singmenu_page.dart';
import 'package:maquinapp/Pages/src/provider/google_sign_in.dart';
import 'package:maquinapp/models/document_users.dart';
import 'package:provider/provider.dart';

import 'src/search_list_page.dart';

final usersRef = FirebaseFirestore.instance.collection("Users");

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User user = FirebaseAuth.instance.currentUser!;

  Future<String> obtenerNombre() async {
    if (user.displayName.toString().isNotEmpty &&
        user.displayName.toString() != "null") {
      return user.displayName.toString();
    } else {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection("Users").get();
      List<DocumentUsers> users = snapshot.docs
          .map((docSnapshot) => DocumentUsers.fromDocumentSnapshot(docSnapshot))
          .toList();
      for (DocumentUsers userInfo in users) {
        if (userInfo.uid == user.uid) {
          return userInfo.nombre;
        }
      }
    }
    return 'User';
  }

  Future<String> obtenerFoto() async {
    if (user.photoURL.toString().isNotEmpty) {
      return user.photoURL.toString();
    } else {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection("Users").get();
      List<DocumentUsers> users = snapshot.docs
          .map((docSnapshot) => DocumentUsers.fromDocumentSnapshot(docSnapshot))
          .toList();
      for (DocumentUsers userInfo in users) {
        if (userInfo.uid == user.uid) {
          return userInfo.fotoperfil.toString();
        }
      }
    }
    return 'null';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
      drawer: _drawerMaquinapp(size),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {},
                child: Ink(
                  decoration: BoxDecoration(
                    color: const Color(0XFF20536F),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    height: 50,
                    width: size.width * 0.8,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.map,
                          color: Color(0xFFFDD835),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'CAMBIAR A MAPA',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              WidgetTrabajo(
                onTap: () {},
                size: size,
                categoria: 'Constructores',
                cliente: 'Marissa',
                descripcion:
                    'Buenas noches, neceisot una construcción de casa en donde yo pueda...',
                distancia: '3.29 km',
                fecha: '30/03/2022',
                title: 'Construcción en casa',
                costo: '1809',
                img:
                    'https://cdn.pixabay.com/photo/2019/04/15/18/13/bathroom-4130000_960_720.jpg',
              ),
              WidgetTrabajo(
                onTap: () {},
                size: size,
                categoria: 'Constructores',
                cliente: 'Marissa',
                descripcion:
                    'Buenas noches, neceisot una construcción de casa en donde yo pueda...',
                distancia: '3.29 km',
                fecha: '30/03/2022',
                title: 'Construcción en casa',
                img:
                    'https://cdn.pixabay.com/photo/2016/11/18/17/46/house-1836070_960_720.jpg',
                costo: '1809',
              ),
              WidgetTrabajo(
                onTap: () {},
                size: size,
                categoria: 'Constructores',
                cliente: 'Marissa',
                descripcion:
                    'Buenas noches, neceisot una construcción de casa en donde yo pueda...',
                distancia: '3.29 km',
                fecha: '30/03/2022',
                title: 'Construcción en casa',
                img: '',
                costo: '1809',
              ),
              WidgetTrabajo(
                onTap: () {},
                size: size,
                categoria: 'Constructores',
                cliente: 'Marissa',
                descripcion:
                    'Buenas noches, neceisot una construcción de casa en donde yo pueda...',
                distancia: '3.29 km',
                fecha: '30/03/2022',
                title: 'Construcción en casa',
                img:
                    'https://cdn.pixabay.com/photo/2015/12/07/10/49/electrician-1080554_960_720.jpg',
                costo: '1809',
              ),
            ],
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
              child: FutureBuilder(
                future: obtenerNombre(),
                builder: (context, dataName) {
                  if (dataName.hasError) {
                    return const Text('Error');
                  } else if (dataName.hasData) {
                    return Row(
                      children: [
                        FutureBuilder(
                          future: obtenerFoto(),
                          builder: (context, dataPhoto) {
                            if (dataPhoto.hasError) {
                              return const Text('Error');
                            } else if (dataPhoto.hasData) {
                              return dataPhoto.data == "null"
                                  ? CircleAvatar(
                                      backgroundColor: Color(
                                              (math.Random().nextDouble() *
                                                      0xFFFFFF)
                                                  .toInt())
                                          .withOpacity(1.0),
                                      radius: 50,
                                      child: Text(
                                        dataName.data.toString()[0],
                                        style: const TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : CircleAvatar(
                                      backgroundColor: const Color(0xFFFDD835),
                                      radius: 50,
                                      backgroundImage: NetworkImage(
                                        dataPhoto.data.toString(),
                                      ),
                                    );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            children: [
                              Text(
                                dataName.data.toString(),
                                style: const TextStyle(
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
                    );
                  } else {
                    return const LinearProgressIndicator();
                  }
                },
              ),
            ),
            ListTile(
              onTap: () {
                //print(user.photoURL.toString());
              },
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
              onTap: () async {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                bool result = await provider.googleLogout();
                if (!result) {
                  await FirebaseAuth.instance.signOut();
                }
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

class WidgetTrabajo extends StatelessWidget {
  const WidgetTrabajo({
    Key? key,
    required this.size,
    required this.title,
    required this.fecha,
    required this.descripcion,
    required this.categoria,
    required this.cliente,
    required this.distancia,
    required this.costo,
    required this.img,
    this.onTap,
  }) : super(key: key);

  final Size size;
  final String title;
  final String fecha;
  final String descripcion;
  final String categoria;
  final String cliente;
  final String distancia;
  final String costo;
  final String img;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.95,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(fecha),
              ],
            ),
            img != ''
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Image.network(
                      img,
                      fit: BoxFit.fitWidth,
                    ),
                  )
                : const SizedBox(
                    height: 20,
                  ),
            Text(descripcion),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                width: size.width * 0.89,
                child: Wrap(
                  spacing: 60,
                  runSpacing: 10,
                  direction: Axis.horizontal,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: [
                          const WidgetSpan(
                            child: Icon(
                              Icons.cases_outlined,
                              color: Color(0xFFFDD835),
                            ),
                          ),
                          TextSpan(text: categoria),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: [
                          const WidgetSpan(
                            child: Icon(
                              Icons.person,
                              color: Color(0xFFFDD835),
                            ),
                          ),
                          TextSpan(text: cliente),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: [
                          const WidgetSpan(
                            child: Icon(
                              Icons.map,
                              color: Color(0xFFFDD835),
                            ),
                          ),
                          TextSpan(text: distancia),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              costo,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
