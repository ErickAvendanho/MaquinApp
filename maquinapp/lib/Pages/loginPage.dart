import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF3B3A38),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Iniciar Sesion",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text("Ingresa con correo y contraseña \n o con tus redes sociales",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}

class SingForm extends StatefulWidget {
  @override
  _SingFormState createState() => _SingFormState();
}

class _SingFormState extends State<SingForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Correo",
              hintText: "Introduce tu correo electrónico",
              enabledBorder: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
