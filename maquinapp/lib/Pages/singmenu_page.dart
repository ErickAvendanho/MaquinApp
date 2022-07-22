import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/login_page.dart';
import 'package:permission_handler/permission_handler.dart';

import 'type_signup_page.dart';

class SignPage extends StatefulWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  Future requestGPSPermission() async {
    final locationStatus = await Permission.location.status;
    final locationWhenInUseStatus = await Permission.locationWhenInUse.status;
    while (locationStatus.isDenied || locationWhenInUseStatus.isDenied) {
      if (locationStatus.isDenied) {
        await Permission.location.request();
      }
      if (locationWhenInUseStatus.isDenied) {
        await Permission.locationWhenInUse.request();
      }
    }
  }

  @override
  void initState() {
    requestGPSPermission();
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
      backgroundColor: const Color(0XFFFDD734),
      appBar: AppBar(
        backgroundColor: const Color(0XFFFDD734),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0XFF3B3A38),
          ),
          onPressed: () => {
            Navigator.pop(context),
          },
        ),
      ),
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
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    ),
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
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TypeSignUpPage()))
                  },
                  child: const Text('REGISTRARSE'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
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
