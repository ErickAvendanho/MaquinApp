import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/signup/register_page_second.dart';

class RegisterPageFirst extends StatefulWidget {
  final String tipoRegistro;
  const RegisterPageFirst({Key? key, required this.tipoRegistro})
      : super(key: key);

  @override
  _RegisterPageFirstState createState() => _RegisterPageFirstState();
}

class _RegisterPageFirstState extends State<RegisterPageFirst> {
  // Initial Selected Value
  String dropdown1value = 'Actividad';
  String dropdown2value = 'Categoría';

  // List of items in our dropdown menu
  var actividad = [
    'Arrendar',
    'Contratar',
  ];

  var itemsArrendar = [
    'Maquinas',
    'Herramientas',
    'Vehiculos y camiones',
    'Accesroios',
    'Otros'
  ];

  var itemsContratar = [
    'Constructores',
    'Prevencionista',
    'Topografos',
    'Arquitectos',
    'Dibujantes tecnicos',
    'Chofer',
    'Operador de maquinarias',
    'Capataz',
    'Trazador',
    'Albañil',
    'Carpintero',
    'Electrico',
    'Gasfiter',
    'Hojalatero',
    'Jardinero',
    'Tecnico electronicos',
    'Instalador de TV cable',
    'Mecanicos',
    'Tecnicos en clima',
    'Otros'
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFFDD734),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFFDD734),
          title: Text(
            'Registro de ${widget.tipoRegistro}',
            style: const TextStyle(color: Colors.black),
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
                const Text(
                  "Seleccione la actividad que quiere realizar:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF3B3A38),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownButton(
                  // Initial Value
                  value: dropdown1value,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: actividad.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdown1value = newValue!;
                    });
                  },
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
                      print(dropdown1value),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPageSecond(
                            tipoRegistro: widget.tipoRegistro,
                          ),
                        ),
                      ),
                    },
                    child: const Text('Ofrezco'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
