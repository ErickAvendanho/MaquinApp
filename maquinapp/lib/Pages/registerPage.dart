import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController repeatPassCtrl = TextEditingController();

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
        const Text('Ingrese los siguientes datos'),
        const SizedBox(height: 20),
        formItemsDesign(
          Icons.person,
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: nameCtrl,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.orange.shade600,
                fontWeight: FontWeight.bold,
              ),
              hintText: 'Nombre',
              hintStyle: const TextStyle(color: Colors.white),
            ),
            validator: validateName,
            textInputAction: TextInputAction.next,
          ),
        ),
        formItemsDesign(
          Icons.email,
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: emailCtrl,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.orange.shade600,
                fontWeight: FontWeight.bold,
              ),
              hintText: 'Correo',
              hintStyle: const TextStyle(color: Colors.white),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            textInputAction: TextInputAction.next,
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: const Color(0XFF343331),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: CountryCodePicker(
                  textStyle: const TextStyle(color: Colors.white),
                  dialogBackgroundColor: Colors.white,
                  dialogSize: Size(size.width * 0.9, size.height * 0.7),
                  dialogTextStyle: const TextStyle(color: Color(0XFF20536F)),
                  onChanged: print,
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection: 'MX',
                  favorite: const ['+52', 'MX'],
                  // optional. Shows only country name and flag
                  showCountryOnly: false,
                  // optional. Shows only country name and flag when popup is closed.
                  showOnlyCountryWhenClosed: false,
                  // optional. aligns the flag and the Text left
                  alignLeft: false,
                ),
              ),
            ),
            Expanded(
              child: formItemsDesign(
                Icons.phone,
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: mobileCtrl,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.orange.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    hintText: 'Telefono',
                    hintStyle: const TextStyle(color: Colors.white),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: validateMobile,
                  textInputAction: TextInputAction.next,
                ),
              ),
            ),
          ],
        ),
        formItemsDesign(
          Icons.password,
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: passwordCtrl,
            obscureText: true,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.orange.shade600,
                fontWeight: FontWeight.bold,
              ),
              hintText: 'Contraseña',
              hintStyle: const TextStyle(color: Colors.white),
            ),
            validator: validatePassword,
            textInputAction: TextInputAction.next,
          ),
        ),
        formItemsDesign(
          Icons.password,
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: repeatPassCtrl,
            obscureText: true,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.orange.shade600,
                fontWeight: FontWeight.bold,
              ),
              hintText: 'Confirmar contraseña',
              hintStyle: const TextStyle(color: Colors.white),
            ),
            validator: validatePassword,
            textInputAction: TextInputAction.done,
          ),
        ),
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
              "Continuar",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            padding: const EdgeInsets.only(top: 16, bottom: 16),
          ),
        ),
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
    RegExp regExp = RegExp(pattern);
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
