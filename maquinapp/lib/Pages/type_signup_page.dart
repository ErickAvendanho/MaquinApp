import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/signup/register_page_first.dart';
import 'package:maquinapp/Pages/signup/register_page_second.dart';

class TypeSignUpPage extends StatelessWidget {
  const TypeSignUpPage({Key? key}) : super(key: key);

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
            color: Colors.black,
          ),
          splashColor: Colors.transparent,
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
                padding: const EdgeInsets.only(bottom: 20.0),
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
              const SizedBox(height: 10),
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
                        builder: (context) => const RegisterPageSecond(
                          tipoRegistro: 'arrendador',
                          esArrendatario: false,
                          actividad: '',
                          categoria: '',
                        ),
                      ),
                    ),
                  },
                  child: const Text('Ofrezco'),
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
                        builder: (context) => const RegisterPageFirst(
                          tipoRegistro: 'arrendatario',
                          esArrendatario: true,
                        ),
                      ),
                    ),
                  },
                  child: const Text('Busco'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
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
