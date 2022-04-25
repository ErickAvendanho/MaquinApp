import 'package:flutter/material.dart';

class RegisterPage2 extends StatefulWidget {
  final String tipoRegistro;
  const RegisterPage2({
    Key? key,
    required this.tipoRegistro,
  }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage2> {
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController communeCtrl = TextEditingController();
  TextEditingController businessNameCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFFFDD734),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFFDD734),
          title: const Text(
            'Registro de Arrendador',
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
          child: Container(
            margin: const EdgeInsets.all(20.0),
            child: Form(
              key: keyForm,
              child: formUI(),
            ),
          ),
        ),
      ),
    );
  }

  formItemsDesign(icon, item) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Card(
        child: ListTile(
          leading: Icon(
            icon,
            color: const Color(0xFFFDD734),
          ),
          title: item,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: const Color(0xFF343436),
      ),
    );
  }

  Widget formUI() {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Image.asset('assets/images/maquinapp.png', width: 100, height: 100),
        const SizedBox(height: 20),
        const Text(
          'Ingresa los datos de tu negocio',
          style: TextStyle(fontSize: 15),
        ),
        const SizedBox(height: 20),
        formItemsDesign(
          Icons.place,
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: communeCtrl,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.orange.shade600,
                fontWeight: FontWeight.bold,
              ),
              hintText: 'Comuna',
              hintStyle: const TextStyle(color: Colors.white),
            ),
            validator: validateCommune,
            textInputAction: TextInputAction.next,
          ),
        ),
        formItemsDesign(
          Icons.storefront,
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: businessNameCtrl,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.orange.shade600,
                fontWeight: FontWeight.bold,
              ),
              hintText: 'Nombre del negocio',
              hintStyle: const TextStyle(color: Colors.white),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: validateBusinessName,
            textInputAction: TextInputAction.next,
          ),
        ),
        SizedBox(height: 40),
        GestureDetector(
          onTap: () {
            save();
          },
          child: Container(
            margin: const EdgeInsets.all(30.0),
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              color: const Color(0xFF343436),
            ),
            child: const Text(
              "SIGUIENTE",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            padding: const EdgeInsets.only(top: 16, bottom: 16),
          ),
        ),
        SizedBox(height: 50),
        Image.asset('assets/images/logomaquina.png', width: 200, height: 100),
      ],
    );
  }

  String? validateCommune(String? value) {
    if (value?.length == 0) {
      return "La comuna es necesaria";
    }
    return null;
  }

  String? validateBusinessName(String? value) {
    if (value?.length == 0) {
      return "El nombre del negocio es necesario";
    }
    return null;
  }

  save() {
    if (keyForm.currentState!.validate()) {
    } else {}
  }
}