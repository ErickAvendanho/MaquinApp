import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maquinapp/Pages/home/components/addjob/addjob_controller.dart';
import 'package:maquinapp/Pages/home/home_page.dart';
import 'package:maquinapp/Pages/widgets/alerts.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({Key? key}) : super(key: key);

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController precioCtrl = TextEditingController();
  TextEditingController descripcionCtrl = TextEditingController();
  TextEditingController direccionCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController fechaCtrl = TextEditingController();
  late DateTime fechaFirebase;
  final User user = FirebaseAuth.instance.currentUser!;
  String actividad = 'Arrendar';
  String categoriaArrendar = 'Maquinas';
  String categoriaContratar = 'Constructores';
  bool esArrendar = true;
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

  final AddJobController _controller = AddJobController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFFDD835),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF3B3A38),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Nuevo trabajo',
          style: TextStyle(
            color: Color(0xFFFDD835),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: size.width * 0.30,
                      child: Image.asset('assets/images/maquinapp.png'),
                    ),
                  ),
                  _textBox(
                      'Titulo',
                      Icons.title,
                      tituloCtrl,
                      TextInputType.text,
                      TextInputAction.next,
                      false,
                      validarTitulo),
                  const SizedBox(height: 10),
                  _textBox(
                      'Precio',
                      Icons.money,
                      precioCtrl,
                      TextInputType.number,
                      TextInputAction.next,
                      false,
                      validarPrecio),
                  const SizedBox(height: 10),
                  _textBox(
                      'Descripción',
                      Icons.description,
                      descripcionCtrl,
                      TextInputType.text,
                      TextInputAction.next,
                      true,
                      validarDescripcion),
                  const SizedBox(height: 10),
                  _textBox(
                      'Dirección',
                      Icons.location_on_sharp,
                      direccionCtrl,
                      TextInputType.text,
                      TextInputAction.next,
                      true,
                      validarDireccion),
                  const SizedBox(height: 10),
                  _textBox(
                      'Teléfono',
                      Icons.phone,
                      telefonoCtrl,
                      TextInputType.number,
                      TextInputAction.next,
                      true,
                      validarTelefono),
                  const SizedBox(height: 10),
                  _textBox(
                      'Correo electrónico',
                      Icons.email,
                      emailCtrl,
                      TextInputType.text,
                      TextInputAction.next,
                      true,
                      validarEmail),
                  const SizedBox(height: 10),
                  formItemsDesign(
                    IconButton(
                      onPressed: () {
                        _controller.selectDate(context);
                      },
                      icon: const Icon(Icons.calendar_month_outlined),
                    ),
                    Text(
                      "${_controller.selectedDate.toLocal()}".split(' ')[0],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                  _ddbActividad(),
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
                  _ddbCategoria(),
                  const SizedBox(height: 10),
                  const Text(
                    "Selecciona las imágenes para tu trabajo.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF3B3A38),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _imagenesSel(size),
                  const SizedBox(height: 10),
                  _buttonUpdate(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _ddbCategoria() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0XFF3B3A38),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          value: esArrendar ? categoriaArrendar : categoriaContratar,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          icon: const Icon(Icons.keyboard_arrow_down),
          dropdownColor: Colors.grey.shade700,
          items: esArrendar
              ? itemsArrendar.map(
                  (String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  },
                ).toList()
              : itemsContratar.map(
                  (String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  },
                ).toList(),
          onChanged: (String? newValue) {
            setState(
              () {
                esArrendar
                    ? categoriaArrendar = newValue!
                    : categoriaContratar = newValue!;
              },
            );
          },
        ),
      ),
    );
  }

  Container _ddbActividad() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0XFF3B3A38),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          value: actividad,
          icon: const Icon(Icons.keyboard_arrow_down),
          style: const TextStyle(color: Colors.white, fontSize: 16),
          dropdownColor: Colors.grey.shade700,
          items: itemsActividad.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(
              () {
                actividad = newValue!;
                if (actividad == 'Arrendar') {
                  esArrendar = true;
                } else {
                  esArrendar = false;
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _textBox(
      String hint,
      IconData icon,
      TextEditingController controller,
      TextInputType tit,
      TextInputAction tia,
      bool isMultiline,
      String? Function(String?)? validador) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
        color: const Color(0XFF3B3A38),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: tit,
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(
            icon,
            color: Colors.amber,
          ),
        ),
        textInputAction: tia,
        maxLines: isMultiline ? null : 1,
        validator: validador,
      ),
    );
  }

  Widget _buttonUpdate() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: () {
          save();
        },
        child: const Text('AGREGAR TRABAJO'),
        style: ElevatedButton.styleFrom(
            primary: const Color(0XFF285D7C),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  String? validarTitulo(String? value) {
    if (value!.isEmpty) {
      return "El título es necesario";
    }
    return null;
  }

  String? validarPrecio(String? value) {
    if (value!.isEmpty) {
      return "El precio es necesario";
    }
    return null;
  }

  String? validarDescripcion(String? value) {
    if (value!.isEmpty) {
      return "La descripción es necesaria";
    }
    return null;
  }

  String? validarDireccion(String? value) {
    if (value!.isEmpty) {
      return "La dirección es necesaria";
    }
    return null;
  }

  String? validarTelefono(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return "El teléfono es necesario";
    } else if (value.length != 10) {
      return "El numero debe tener 10 dígitos";
    }
    return null;
  }

  String? validarEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value!.isEmpty) {
      return "El correo electrónico es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "Correo inválido";
    } else {
      return null;
    }
  }

  String? validarFecha(String? value) {
    if (value!.isEmpty) {
      return "La fecha es necesaria";
    }
    return null;
  }

  void save() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.reset();
      fechaFirebase =
          DateTime.parse(_controller.selectedDate.toLocal().toString());
      Alerts.messageLoading(context);
      if (await _controller.crearTrabajoArrendador(
          tituloCtrl.text,
          precioCtrl.text,
          descripcionCtrl.text,
          direccionCtrl.text,
          telefonoCtrl.text,
          emailCtrl.text,
          fechaFirebase,
          actividad,
          esArrendar ? categoriaArrendar : categoriaContratar,
          user.uid)) {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0XFF3B3A38),
            elevation: 5,
            margin: const EdgeInsets.all(10),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: const Text.rich(
              TextSpan(
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Icon(
                      Icons.check,
                      color: Color(0xFFFDD835),
                    ),
                  ),
                  TextSpan(
                    text: "Trabajo añadido con éxito",
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        Navigator.pop(context);
        Alerts.messageBoxMessage(
            context, "Hubo un problema", "Intente nuevamente.");
      }
    }
  }

  Widget _imagenesSel(Size size) {
    if (_controller.imagesPaths.isEmpty) {
      return _addImageButton(size);
    } else if (_controller.imagesPaths.isNotEmpty &&
        _controller.imagesPaths.length == 3) {
      return Center(
        child: Wrap(
          children: List.generate(
            _controller.imagesPaths.length,
            (index) => _photoSelected(
              size,
              _controller.imagenesElegidas[index]!,
            ),
          ),
        ),
      );
    } else {
      List<Widget> listImagenes = List.generate(
        _controller.imagesPaths.length,
        (index) => _photoSelected(
          size,
          _controller.imagenesElegidas[index]!,
        ),
      );
      listImagenes.add(_addImageButton(size));
      return Wrap(
        children: listImagenes,
      );
    }
  }

  Card _photoSelected(Size size, PickedFile file) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(2.0),
        width: size.width * 0.20,
        height: size.width * 0.20,
        child: InkWell(
          onTap: () async {
            _controller.imagenesElegidas.remove(file);
            _controller.imagesPaths.remove(file.path);
            setState(() {});
          },
          child: Stack(
            children: [
              Center(
                child: Image.file(
                  File(file.path),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card _addImageButton(Size size) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(2.0),
        width: size.width * 0.20,
        height: size.width * 0.20,
        child: InkWell(
          onTap: () {
            Alerts.messageBoxCustom(
              context,
              const Text("Seleccionar imagen"),
              SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        ImagePicker _picker = ImagePicker();
                        PickedFile? file =
                            await _picker.getImage(source: ImageSource.camera);
                        if (file != null) {
                          _controller.imagenesElegidas.add(file);
                          //print(_controller.imagenesElegidas.length);
                          _controller.imagesPaths
                              .add(_controller.imagenesElegidas.last!.path);
                          Navigator.pop(context);
                          setState(() {});
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: const [
                            Expanded(
                              child: Text('Tomar foto'),
                            ),
                            Icon(Icons.camera_alt),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        ImagePicker _picker = ImagePicker();
                        PickedFile? file =
                            await _picker.getImage(source: ImageSource.gallery);
                        if (file != null) {
                          _controller.imagenesElegidas.add(file);
                          _controller.imagesPaths
                              .add(_controller.imagenesElegidas.last!.path);
                          Navigator.pop(context);
                          setState(() {});
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: const [
                            Expanded(
                              child: Text('Elegir foto de la galería'),
                            ),
                            Icon(Icons.photo),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        style: TextButton.styleFrom(primary: Colors.redAccent),
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancelar"),
                      ),
                    )
                  ],
                ),
              ),
              [],
            );
          },
          child: Stack(
            children: [
              Image.asset('assets/images/add_image.png'),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
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

formItemsDesign(icon, item) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 3),
    decoration: BoxDecoration(
      border: Border.all(),
      borderRadius: BorderRadius.circular(10),
      color: const Color(0XFF3B3A38),
    ),
    child: Card(
        child: ListTile(
            tileColor: const Color(0XFF3B3A38),
            iconColor: Colors.amber,
            leading: icon,
            title: item)),
  );
}
