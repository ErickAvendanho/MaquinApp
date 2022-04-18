import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/loginPage.dart';

class SignPage extends StatelessWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0XFFFDD734),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(70.0),
                child: Image.asset(
                  'assets/images/maquinapp.png',
                  height: size.height * 0.3,
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: const Text('INICIAR SESIÓN'),
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
                  onPressed: () {},
                  child: const Text('REGISTRARSE'),
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
