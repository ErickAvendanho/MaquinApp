import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maquinapp/Pages/home_page.dart';
import 'package:maquinapp/Pages/src/firebaseServices/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _keyForm = GlobalKey();

  late TextEditingController emailCtrl = TextEditingController();
  late TextEditingController passCtrl = TextEditingController();

  @override
  void initState() {
    emailCtrl = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    passCtrl = TextEditingController()
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0XFF3B3A38),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0XFF3B3A38),
        title: const Text('Iniciar sesión'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          splashColor: Colors.transparent,
          onPressed: () => {
            Navigator.pop(context),
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _keyForm,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 60.0),
                  child: Image.asset(
                    'assets/images/maquinapp.png',
                    height: size.height * 0.3,
                  ),
                ),
                TextBox(
                  size: size,
                  icon: Icons.email,
                  hintText: 'Correo electrónico',
                  isPassword: false,
                  controller: emailCtrl,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.emailAddress,
                ),
                TextBox(
                  size: size,
                  icon: Icons.key_rounded,
                  hintText: 'Contraseña',
                  isPassword: true,
                  controller: passCtrl,
                  inputAction: TextInputAction.done,
                  inputType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 20,
                ),
                _buttonSignIn(size),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: size.width * 0.7,
                  child: const Divider(
                    thickness: 2,
                    color: Color(0XFFFED246),
                  ),
                ),
                SizedBox(
                  width: size.width * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.facebook,
                            color: Colors.blue.shade600,
                          ),
                          iconSize: 48,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: InkWell(
                          onTap: () => {},
                          child: Image.asset(
                            'assets/images/google.png',
                            width: 40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton _buttonSignIn(Size size) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 10,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () {
        signIn();
      },
      child: Ink(
        decoration: BoxDecoration(
          color: const Color(0XFF20536F),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          height: 50,
          width: size.width * 0.6,
          alignment: Alignment.center,
          child: const Text(
            'INICIAR SESIÓN',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (_keyForm.currentState!.validate()) {
      AuthServices as = AuthServices();
      UserCredential? uc = await as.singIn(emailCtrl.text, passCtrl.text);
      if (uc != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const HomePage(),
          ),
          (route) => false,
        );
      }
    }
  }
}

class TextBox extends StatelessWidget {
  const TextBox({
    Key? key,
    required this.size,
    required this.icon,
    required this.hintText,
    required this.isPassword,
    required this.controller,
    required this.inputAction,
    required this.inputType,
  }) : super(key: key);

  final Size size;
  final IconData icon;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputAction inputAction;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: const Color(0XFFFED246),
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFormField(
        autofocus: false,
        keyboardType: inputType,
        textInputAction: inputAction,
        controller: controller,
        cursorColor: const Color(0XFF343331),
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Colors.red.shade400,
            fontWeight: FontWeight.bold,
          ),
          icon: Icon(
            icon,
            color: const Color(0XFF343331),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 116, 98, 39)),
          border: InputBorder.none,
        ),
        style: const TextStyle(
          color: Color(0XFF343331),
        ),
        obscureText: isPassword,
        validator: (value) {
          if (value!.isEmpty) {
            return 'El campo está vacío.';
          }
          if (inputType == TextInputType.emailAddress &&
              (!value.contains(RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")))) {
            return 'El formato no es válido.';
          }
          return null;
        },
      ),
    );
  }
}
