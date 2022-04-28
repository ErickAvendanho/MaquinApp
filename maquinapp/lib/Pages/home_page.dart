import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:maquinapp/Pages/singmenu_page.dart';
import 'package:maquinapp/Pages/src/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'src/search_list_page.dart';

final usersRef = FirebaseFirestore.instance.collection("Users").doc();

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User user = FirebaseAuth.instance.currentUser!;
  late String photoURL;
  late String displayName;

  void obtenerDatos() {
    try {
      photoURL = user.photoURL!;
    } catch (e) {
      photoURL = '';
    }
    try {
      displayName = user.displayName!;
    } catch (e) {
      try {
        displayName = "Algun nombre";
      } catch (e) {
        displayName = 'usuario';
      }
    }
  }

  void getUsers() async {
    /*var document = FirebaseFirestore.instance.doc('Users/Xhn1Ge6mQ43qDllgAZDs');
    document.get().then((document) {
      print(document.data());
    });*/
    /*
    FirebaseFirestore.instance
        .collection('Users')
        .doc('Xhn1Ge6mQ43qDllgAZDs')
        .get()
        .then((DocumentSnapshot document) {
      print("x value: ${document['nombre']}");
    });*/
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('Users');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    print(allData[0]);
  }

  @override
  void initState() {
    getUsers();
    obtenerDatos();
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
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDD835),
        title: Image.asset(
          'assets/images/logomaquina.png',
          height: size.height * 0.15,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchList(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: _drawerMaquinapp(size),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: const [],
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
                  photoURL == ""
                      ? CircleAvatar(
                          backgroundColor: Color(
                                  (math.Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                              .withOpacity(1.0),
                          radius: 50,
                          child: Text(
                            "prueba",
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
                            photoURL,
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      children: [
                        Text(
                          displayName,
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
