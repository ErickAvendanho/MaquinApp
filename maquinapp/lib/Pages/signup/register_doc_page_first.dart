import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/signup/register_doc_page_second.dart';
import 'package:maquinapp/Pages/src/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../singmenu_page.dart';

class RegisterDocPageFirst extends StatelessWidget {
  const RegisterDocPageFirst({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0XFFFDD734),
      appBar: AppBar(
        backgroundColor: const Color(0XFFFDD734),
        elevation: 0,
        title: const Text(
          'Complete su registro',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          tooltip: 'Cerrar sesión',
          onPressed: () async {
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
          icon: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 70.0),
                child: Image.asset(
                  'assets/images/maquinapp.png',
                  height: size.height * 0.3,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Seleccione como quiere registrarse",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF3B3A38),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0XFF3B3A38),
                    fixedSize: Size(size.width * 0.75, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterDocPageSecond(
                          tipoRegistro: 'arrendador',
                        ),
                      ),
                    ),
                  },
                  child: const Text('ARRENDADOR'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0XFF3B3A38),
                    fixedSize: Size(size.width * 0.75, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterDocPageSecond(
                          tipoRegistro: 'arrendatario',
                        ),
                      ),
                    ),
                  },
                  child: const Text('ARRENDATARIO'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(70.0),
                child: Image.asset(
                  'assets/images/logomaquina.png',
                  height: size.height * 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
