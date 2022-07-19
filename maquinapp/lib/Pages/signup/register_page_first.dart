import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/signup/register_page_second.dart';

class RegisterPageFirst extends StatefulWidget {
  final String tipoRegistro;
  final bool esArrendatario;
  const RegisterPageFirst(
      {Key? key, required this.tipoRegistro, required this.esArrendatario})
      : super(key: key);

  @override
  _RegisterPageFirstState createState() => _RegisterPageFirstState();
}

class _RegisterPageFirstState extends State<RegisterPageFirst> {
  // Initial Selected Value
  String actividad = 'Arrendar';
  String categoriaArrendar = 'Maquinas';
  String categoriaContratar = 'Constructores';
  bool esArrendar = true;

  // List of items in our dropdown menu

  var itemsActividad = [
    'Arrendar',
    'Contratar',
  ];

  var itemsArrendar = [
    'Maquinas',
    'Herramientas',
    'Vehiculos y camiones',
    'Accesorios',
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
                  value: actividad,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: itemsActividad.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      actividad = newValue!;
                      if (actividad == 'Arrendar') {
                        esArrendar = true;
                      } else {
                        esArrendar = false;
                      }
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Seleccione una categoría:",
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
                  value: esArrendar ? categoriaArrendar : categoriaContratar,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: esArrendar
                      ? itemsArrendar.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList()
                      : itemsContratar.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      esArrendar
                          ? categoriaArrendar = newValue!
                          : categoriaContratar = newValue!;
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
                      print(actividad),
                      esArrendar
                          ? print(categoriaArrendar)
                          : print(categoriaContratar),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPageSecond(
                            tipoRegistro: widget.tipoRegistro,
                            esArrendatario: widget.esArrendatario,
                            actividad: actividad,
                            categoria: esArrendar
                                ? categoriaArrendar
                                : categoriaContratar,
                          ),
                        ),
                      ),
                    },
                    child: const Text('Siguiente'),
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
