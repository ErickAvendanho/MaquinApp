import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/home/home_map_page.dart';
import 'package:maquinapp/Pages/home/services/product_page.dart';
import 'dart:math' as math;

import 'package:maquinapp/Pages/singmenu_page.dart';
import 'package:maquinapp/Pages/src/provider/google_sign_in.dart';
import 'package:maquinapp/models/document_user.dart';
import 'package:maquinapp/models/trabajos_arrendatario.dart';
import 'package:provider/provider.dart';

import '../src/search_list_page.dart';
import 'widgets/widget_trabajo.dart';

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
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(user.uid.toString())
              .get();
      if (docSnapshot.exists) {
        DocumentUser userDoc = DocumentUser();
        userDoc.fromMap(docSnapshot.data());
        return userDoc.nombre.toString();
      }
    }
    return 'User';
  }

  Future<String> obtenerFoto() async {
    if (user.photoURL.toString().isNotEmpty) {
      return user.photoURL.toString();
    } else {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(user.uid.toString())
              .get();
      if (docSnapshot.exists) {
        DocumentUser userDoc = DocumentUser();
        userDoc.fromMap(docSnapshot.data());
        return userDoc.fotoperfil.toString();
      }
    }
    return 'null';
  }

  Future<List<TrabajosArrendatario>> getJobs() async {
    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("TrabajosArrendatario")
        .get();
    List<DocumentSnapshot> documents = qs.docs;
    return documents
        .map(
          (e) => TrabajosArrendatario(
            descripcion: e["descripcion"],
            uid: e["uid"],
            fecha: e["fecha"],
            tipo: e["tipo"],
            longitud: e["longitud"],
            latitud: e["latitud"],
            precio: e["precio"],
            foto: e["foto"],
            titulo: e["titulo"],
            usuario: e["usuario"],
          ),
        )
        .toList();
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
      drawer: _drawerMaquinApp(context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeMapPage()));
                },
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
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                future: getJobs(),
                builder: (context, data) {
                  if (data.hasData) {
                    List<TrabajosArrendatario> trabajos =
                        data.data as List<TrabajosArrendatario>;
                    return ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: trabajos.isEmpty ? 0 : trabajos.length,
                      itemBuilder: (context, int index) {
                        return WidgetTrabajo(
                            onTap: () {},
                            size: size,
                            title: trabajos[index].titulo.toString(),
                            fecha: trabajos[index].fecha.toString(),
                            descripcion: trabajos[index].descripcion.toString(),
                            categoria: trabajos[index].tipo.toString(),
                            cliente: trabajos[index].usuario.toString(),
                            distancia: '3.29 KM',
                            costo: trabajos[index].precio.toString(),
                            img: trabajos[index].foto.toString());
                      },
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(30),
                      child: CircularProgressIndicator(
                        color: Color(0XFF20536F),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
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
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductPage()));},
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
