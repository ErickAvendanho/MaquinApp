import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddJobController {
  DateTime selectedDate = DateTime.now();
  late BuildContext context;
  User? user = FirebaseAuth.instance.currentUser;
  List<PickedFile?> imagenesElegidas = [];
  List<String> imagesPaths = [];
  List<String?> linksImagenes = [];
  String? link = "";

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
      for (var img in imagenesElegidas) {
        link = await uploadImage(img);
        linksImagenes.add(link);
      }
      if (linksImagenes.any((element) => element == null)) {
        return false;
      } else {
        CollectionReference trabajosArrendatariosRef =
            FirebaseFirestore.instance.collection('TrabajosArrendatarios');
        String uidGen = getRandomString(20);
        await trabajosArrendatariosRef
            .doc(uidGen)
            .set({
              'titulo': titulo,
              'precio': precio,
              'descripcion': descripcion,
              'direccion': direccion,
              'telefono': telefono,
              'email': email,
              'fecha': fechaFirebase,
              'actividad': actividad,
              'categoria': categoria,
              'uidArrendador': uidArrendador,
              'fotos': linksImagenes,
              'id': uidGen,
            })
            .then((value) => result = true)
            .catchError((error) => result = false);
      }
      return result;
    } catch (e) {
      return result;
    }
  }

  Future<bool> actualizarTrabajoArrendador(
      String titulo,
      String precio,
      String descripcion,
      String direccion,
      String telefono,
      String email,
      DateTime fechaFirebase,
      String actividad,
      String categoria,
      String uidArrendador,
      String? id) async {
    bool result = false;
    final db = FirebaseFirestore.instance.collection('TrabajosArrendatarios').doc(id);

    try {
      for (var img in imagenesElegidas) {
        link = await uploadImage(img);
        linksImagenes.add(link);
      }
      if (linksImagenes.any((element) => element == null)) {
        return false;
      } else {
        await db.update({
              'titulo': titulo,
              'precio': precio,
              'descripcion': descripcion,
              'direccion': direccion,
              'telefono': telefono,
              'email': email,
              'fecha': fechaFirebase,
              'actividad': actividad,
              'categoria': categoria,
              'uidArrendador': uidArrendador,
              'fotos': linksImagenes
            })
            .then((value) => result = true)
            .catchError((error) => result = false);
      }
      return result;
    } catch (e) {
      return result;
    }
  }

  Future<String?> uploadImage(PickedFile? imagen) async {
    try {
      var file = File(imagen!.path);
      final Reference storageReference =
          FirebaseStorage.instance.ref().child("ImagenesTrabajos");

      TaskSnapshot taskSnapshot = await storageReference
          .child("${getRandomString(10)}.jpg")
          .putFile(file);

      var downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (ex) {
      print('Error al subir imagen: $ex');
      return null;
    }
  }

  String getRandomString(int length) {
    const characters = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    Random random = Random();
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => characters.codeUnitAt(
          random.nextInt(characters.length),
        ),
      ),
    );
  }
}
