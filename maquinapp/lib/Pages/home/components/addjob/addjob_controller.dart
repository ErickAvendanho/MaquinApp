import 'package:flutter/material.dart';
import 'dart:math' as m;
import '../../../../models/trabajos_arrendatario.dart';

class ProductController {
  late BuildContext context;
  TextEditingController tituloController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController usuarioController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  void showAlertDialog() {
    Widget gallerryButton =
        ElevatedButton(onPressed: () {}, child: const Text('GALERIA'));

    Widget cameraButton =
        ElevatedButton(onPressed: () {}, child: const Text('GALERIA'));

    AlertDialog alertDialog = AlertDialog(
      title: const Text('Selecciona tu imagen'),
      actions: [gallerryButton, cameraButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext contex) {
          return alertDialog;
        });
  }

  void uploadNewJob(TrabajosArrendatario job) async {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    m.Random _rnd = m.Random();
    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    await job.agregarJob(getRandomString.toString());
  }
}
