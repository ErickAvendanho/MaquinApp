import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math' as m;
import '../../../../models/trabajos_arrendatario.dart';

class AddJobController {
  DateTime selectedDate = DateTime.now();
  late BuildContext context;
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        locale: const Locale('es', 'ES'),
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
    }
  }

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

  Future<bool> crearTrabajoArrendador(
      String titulo,
      String precio,
      String descripcion,
      String direccion,
      String telefono,
      String email,
      DateTime fechaFirebase,
      String actividad,
      String categoria,
      String uidArrendador) async {
    bool result = false;

    try {
      CollectionReference trabajosArrendadorRef =
          FirebaseFirestore.instance.collection('TrabajosArrendador');
      await trabajosArrendadorRef
          .doc()
          .set({
            'Titulo': titulo,
            'Precio': precio,
            'Descripcion': descripcion,
            'Direccion': direccion,
            'Telefono': telefono,
            'email': email,
            'Fecha': fechaFirebase,
            'Actividad': actividad,
            'Categoria': categoria,
            'uidArrendador': uidArrendador
          })
          .then((value) => result = true)
          .catchError((error) => result = false);
      return result;
    } catch (e) {
      return result;
    }
  }
}
