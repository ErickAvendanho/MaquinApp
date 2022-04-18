import 'package:flutter/material.dart';

class SignInUpp extends StatelessWidget {
  const SignInUpp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0XFFFDD734),
      body: Column(
        children: [
          Image.asset(''),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0XFF3B3A38),
              fixedSize: const Size(300, 90),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () {},
            child: const Text('INICIAR SESIÓN'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: const Color(0XFF3B3A38),
              fixedSize: const Size(300, 90),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            onPressed: () {},
            child: const Text('REGISTRARSE'),
          ),
          Image.asset('')
        ],
      ),
    );
  }
}
