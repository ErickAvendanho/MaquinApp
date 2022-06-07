import 'package:flutter/material.dart';

class ProductController {
  late BuildContext context;
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
}
