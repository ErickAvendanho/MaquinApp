import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' as math;

import 'package:maquinapp/Pages/singmenu_page.dart';
import 'package:maquinapp/Pages/src/provider/google_sign_in.dart';
import 'package:maquinapp/models/document_user.dart';
import 'package:maquinapp/models/trabajos_arrendatario.dart';
import 'package:provider/provider.dart';

import '../src/search_list_page.dart';

class HomeMapPage extends StatefulWidget {
  const HomeMapPage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeMapPage> createState() => _HomeMapPageState();
}

class _HomeMapPageState extends State<HomeMapPage> {
  final User user = FirebaseAuth.instance.currentUser!;
  int alcance = 1;
  final _initialCameraPosition = const CameraPosition(
    target: LatLng(19.4122119, -98.9913005),
    zoom: 15,
  );

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
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
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
