import 'package:flutter/material.dart';

class RegisterPageThird extends StatefulWidget {
  const RegisterPageThird({Key? key}) : super(key: key);

  @override
  _RegisterPageThridState createState() => _RegisterPageThridState();
}

class _RegisterPageThridState extends State<RegisterPageThird> {
  int alcance = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDD734),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFFDD734),
        title: const Text(
          'Selecciona la ubicación del negocio',
          style: TextStyle(color: Colors.black),
        ),
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
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => {
                      setState(() {
                        if (alcance > 1) {
                          alcance--;
                        }
                      })
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text('Kilómetros: $alcance'),
                  IconButton(
                    onPressed: () => {
                      setState(() {
                        if (alcance < 10) {
                          alcance++;
                        }
                      })
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Container(
                  margin: const EdgeInsets.all(30.0),
                  alignment: Alignment.center,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    color: const Color(0xFF343436),
                  ),
                  child: const Text(
                    'SIGUIENTE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
