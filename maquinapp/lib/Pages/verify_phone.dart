import 'package:flutter/material.dart';

class VerifyPhonePage extends StatefulWidget {
  const VerifyPhonePage({Key? key}) : super(key: key);

  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  final GlobalKey<FormState> _keyForm = GlobalKey();

  late TextEditingController codeCtrl = TextEditingController();

  @override
  void initState() {
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
      backgroundColor: const Color(0XFFFDD734),
      body: Form(
        key: _keyForm,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    Icons.settings_cell,
                    color: Colors.white,
                    size: 128,
                  ),
                ),
                Container(
                  width: size.width * 0.6,
                  margin: const EdgeInsets.all(20),
                  child: const Text(
                    'Verifica tu teléfono',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: size.width * 0.9,
                  margin: const EdgeInsets.all(5),
                  child: const Text(
                    'Ingrese el código de verificación que le hemos enviado.',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: size.width * 0.8,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color(0XFF343436),
                  ),
                  child: TextFormField(
                    controller: codeCtrl,
                    style: const TextStyle(color: Colors.white),
                    autofocus: false,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    cursorColor: const Color(0XFFFDD734),
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(
                        color: Color(0XFFF24504),
                        fontWeight: FontWeight.bold,
                      ),
                      icon: Icon(
                        Icons.lock,
                        color: Color(0XFFFDD734),
                      ),
                      hintText: 'Código de verificación',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 10,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                  child: Container(
                    width: size.width * 0.7,
                    alignment: Alignment.center,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: const Color(0xFF343436),
                    ),
                    child: const Text(
                      "VERIFICAR",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
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
