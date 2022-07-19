import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:maquinapp/Pages/signup/register_page_third.dart';

class RegisterPageSecond extends StatefulWidget {
  final String tipoRegistro;
  final bool esArrendatario;
  final String actividad;
  final String categoria;
  const RegisterPageSecond({
    Key? key,
    required this.tipoRegistro,
    required this.esArrendatario,
    required this.actividad,
    required this.categoria
  }) : super(key: key);

  @override
  _RegisterPageSecondState createState() => _RegisterPageSecondState();
}

class _RegisterPageSecondState extends State<RegisterPageSecond> {
  String? pickedCountryCode = '+52';
  GlobalKey<FormState> keyForm = GlobalKey();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController mobileCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController repeatPassCtrl = TextEditingController();
  bool passwordVisible = false;
  bool repeatPassVisible = false;

  @override
  Widget build(BuildContext context) {
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

  formItemsDesign(icon, item, trailing) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Card(
        child: ListTile(
          leading: Icon(
            icon,
            color: const Color(0xFFFDD734),
          ),
          title: item,
          trailing: trailing,
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
            cursorColor: const Color(0xFFFDD734),
            decoration: InputDecoration(
              border: InputBorder.none,
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
          const SizedBox.shrink(),
        ),
        formItemsDesign(
          Icons.email,
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: emailCtrl,
            cursorColor: const Color(0xFFFDD734),
            decoration: InputDecoration(
              border: InputBorder.none,
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
          const SizedBox.shrink(),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: const Color(0XFF343331),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: CountryCodePicker(
                  textStyle: const TextStyle(color: Colors.white),
                  dialogBackgroundColor: Colors.white,
                  dialogSize: Size(size.width * 0.5, size.height * 0.7),
                  dialogTextStyle: const TextStyle(color: Color(0XFF20536F)),
                  onChanged: (CountryCode cou) {
                    pickedCountryCode = cou.dialCode!;
                  },
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
                  cursorColor: const Color(0xFFFDD734),
                  decoration: InputDecoration(
                    border: InputBorder.none,
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
                const SizedBox.shrink(),
              ),
            ),
          ],
        ),
        formItemsDesign(
          Icons.password,
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: passwordCtrl,
            cursorColor: const Color(0xFFFDD734),
            obscureText: !passwordVisible,
            decoration: InputDecoration(
              border: InputBorder.none,
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
          IconButton(
            onPressed: () => {
              setState(() {
                passwordVisible = !passwordVisible;
              })
            },
            icon: passwordVisible
                ? const Icon(
                    Icons.visibility_off,
                    color: Color(0XFF8B6B34),
                  )
                : const Icon(
                    Icons.visibility,
                    color: Color(0XFF8B6B34),
                  ),
          ),
        ),
        formItemsDesign(
          Icons.password,
          TextFormField(
            style: const TextStyle(color: Colors.white),
            controller: repeatPassCtrl,
            cursorColor: const Color(0xFFFDD734),
            obscureText: !repeatPassVisible,
            decoration: InputDecoration(
              border: InputBorder.none,
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
          IconButton(
            onPressed: () => {
              setState(() {
                repeatPassVisible = !repeatPassVisible;
              })
            },
            icon: repeatPassVisible
                ? const Icon(
                    Icons.visibility_off,
                    color: Color(0XFF8B6B34),
                  )
                : const Icon(
                    Icons.visibility,
                    color: Color(0XFF8B6B34),
                  ),
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
              "CONTINUAR",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            padding: const EdgeInsets.only(top: 16, bottom: 16),
          ),
        ),
        const SizedBox(height: 20),
        Image.asset('assets/images/logomaquina.png', width: 200, height: 100),
      ],
    );
  }

  String? validatePassword(String? value) {
    if (value != passwordCtrl.text) {
      return "Las contraseñas no coinciden";
    }
    if (value!.isEmpty) {
      return "La contraseña es requerida";
    }
    return null;
  }

  String? validateName(String? value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "El nombre es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "El nombre debe de ser a-z y A-Z";
    }
    return null;
  }

  String? validateMobile(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return "Campo necesario";
    } else if (value.length != 10) {
      return "No hay 10 digitos";
    } else if (!regExp.hasMatch(value)) {
      return "Sólo números";
    }
    return null;
  }

  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "El correo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "Correo invalido";
    } else {
      return null;
    }
  }

  void save() async {
    if (keyForm.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterPageThird(
            tipoRegistro: widget.tipoRegistro,
            esArrendatario: widget.esArrendatario,
            actividad: widget.actividad,
            categoria: widget.categoria,
            nombre: nameCtrl.text,
            correo: emailCtrl.text,
            telefono: '$pickedCountryCode${mobileCtrl.text}',
            password: passwordCtrl.text,
          ),
        ),
      );
    } else {}
  }
}
