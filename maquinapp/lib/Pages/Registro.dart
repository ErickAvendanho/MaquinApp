import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> keyForm = new GlobalKey();
  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController mobileCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();
  TextEditingController repeatPassCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        backgroundColor: Color(0xFFFDD734),
        appBar: new AppBar(
          backgroundColor: Color(0xFFFDD734),
          title: Center(
            child: Text(
              'Registro de Arrendador',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(20.0),
            child: new Form(
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
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(
        child: ListTile(
            leading: Icon(icon, color: Color(0xFFFDD734)), title: item),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Color(0xFF343436),
      ),
    );
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        Image.asset('assets/images/maquinapp.png', width: 100, height: 100),
        SizedBox(height: 20),
        Text('Ingrese los siguientes datos'),
        SizedBox(height: 20),
        formItemsDesign(
            Icons.person,
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: nameCtrl,
              decoration: new InputDecoration.collapsed(
                hintText: 'Nombre',
                hintStyle: TextStyle(color: Colors.white),
              ),
              validator: validateName,
            )),
        formItemsDesign(
            Icons.email,
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: emailCtrl,
              decoration: new InputDecoration.collapsed(
                hintText: 'Correo',
                hintStyle: TextStyle(color: Colors.white),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
            )),
        Row(
          children: <Widget>[
            Expanded(
              child: CountryCodePicker(
                onChanged: print,
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection: 'MX',
                favorite: ['+52', 'MX'],
                // optional. Shows only country name and flag
                showCountryOnly: false,
                // optional. Shows only country name and flag when popup is closed.
                showOnlyCountryWhenClosed: false,
                // optional. aligns the flag and the Text left
                alignLeft: false,
              ),
            ),
            Expanded(
              child: formItemsDesign(
                  Icons.phone,
                  TextFormField(
                    style: TextStyle(color: Colors.white),
                    controller: mobileCtrl,
                    decoration: new InputDecoration.collapsed(
                      hintText: 'Telefono',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: validateMobile,
                  )),
            ),
          ],
        ),
        formItemsDesign(
            Icons.password,
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: passwordCtrl,
              obscureText: true,
              decoration: InputDecoration.collapsed(
                hintText: 'Contraseña',
                hintStyle: TextStyle(color: Colors.white),
              ),
              validator: validatePassword,
            )),
        formItemsDesign(
            Icons.password,
            TextFormField(
              style: TextStyle(color: Colors.white),
              controller: repeatPassCtrl,
              obscureText: true,
              decoration: InputDecoration.collapsed(
                hintText: 'Confirmar contraseña',
                hintStyle: TextStyle(color: Colors.white),
              ),
              validator: validatePassword,
            )),
        GestureDetector(
            onTap: () {
              save();
            },
            child: Container(
              margin: new EdgeInsets.all(30.0),
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                color: Color(0xFF343436),
              ),
              child: Text("Continuar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              padding: EdgeInsets.only(top: 16, bottom: 16),
            ))
      ],
    );
  }

  String? validatePassword(String? value) {
    if (value != passwordCtrl.text) {
      return "Las contraseñas no coinciden";
    }
    if (value?.length == 0) {
      return "La contraseña es requerida";
    }
    return null;
  }

  String? validateName(String? value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value?.length == 0) {
      return "El nombre es necesario";
    } else if (!regExp.hasMatch(value!)) {
      return "El nombre debe de ser a-z y A-Z";
    }
    return null;
  }

  String? validateMobile(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value?.length == 0) {
      return "El telefono es necesario";
    } else if (value?.length != 10) {
      return "El numero debe tener 10 digitos";
    }
    return null;
  }

  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value?.length == 0) {
      return "El correo es necesario";
    } else if (!regExp.hasMatch(value!)) {
      return "Correo invalido";
    } else {
      return null;
    }
  }

  save() {
    if (keyForm.currentState!.validate()) {
      print("Nombre ${nameCtrl.text}");
      print("Correo ${emailCtrl.text}");
      print("Telefono ${mobileCtrl.text}");
      print("Password ${passwordCtrl.text}");
      print("Confirmacion password ${repeatPassCtrl.text}");
      keyForm.currentState!.reset();
    }
  }
}
