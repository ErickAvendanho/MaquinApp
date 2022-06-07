import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/singmenu_page.dart';
import 'package:maquinapp/Pages/src/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'Pages/home/home_page.dart';
import 'Pages/signup/register_doc_page_first.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Se asegura de que todas las dependencias estén inicializadas
  Firebase.initializeApp().then((value) => {runApp(const MyApp())});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MaquinApp',
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          home: const MyHomePage(),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    //_delay();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> documentExists() async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await FirebaseFirestore
        .instance
        .collection("Users")
        .doc(user?.uid.toString())
        .get();
    if (docSnapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDD835),
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 210),
                  Image.asset('assets/images/maquinapp.png',
                      width: 300, height: 300),
                  const SizedBox(height: 50),
                  const CircularProgressIndicator(
                    color: Color(0XFF343331),
                  ),
                  const SizedBox(height: 80),
                  Image.asset('assets/images/logomaquina.png',
                      width: 200, height: 97),
                ],
              ),
            );
          } else if (snapshot.hasData) {
            return FutureBuilder(
              future: documentExists(),
              builder: (context, data) {
                if (data.hasData) {
                  bool result = data.data as bool;
                  return result == true
                      ? const HomePage()
                      : const RegisterDocPageFirst();
                } else {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 210),
                        Image.asset('assets/images/maquinapp.png',
                            width: 300, height: 300),
                        const SizedBox(height: 50),
                        const CircularProgressIndicator(
                          color: Color(0XFF343331),
                        ),
                        const SizedBox(height: 80),
                        Image.asset('assets/images/logomaquina.png',
                            width: 200, height: 97),
                      ],
                    ),
                  );
                }
              },
            );
          } else if (snapshot.hasError) {
            return const SignPage();
          } else {
            return const SignPage();
          }
        },
      ),
    );
  }
}
