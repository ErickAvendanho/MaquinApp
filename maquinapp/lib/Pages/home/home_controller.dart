import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maquinapp/Pages/src/inactiveUser.dart';

import '../../models/document_user.dart';
import '../../models/trabajos_arrendatarios.dart';

class HomeController {
  late List<Marker>? markers;
  late bool isUserInactive;
  User? user = FirebaseAuth.instance.currentUser;
  Future<bool> addMarkers() async {
    try {
      QuerySnapshot qs = await FirebaseFirestore.instance
          .collection("TrabajosArrendatarios")
          .get();
      List<DocumentSnapshot> documents = qs.docs;
      for (var document in documents) {
        markers!.add(
          Marker(
            markerId: MarkerId(document.id),
            position: LatLng(
              document["latitud"],
              document["longitud"],
            ),
            infoWindow: InfoWindow(
              title: document["titulo"],
              snippet: document["descripcion"],
            ),
          ),
        );
      }
      await Future.delayed(
        const Duration(
          seconds: 3,
        ),
      );
      return true;
    } catch (e) {
      await Future.delayed(
        const Duration(
          seconds: 3,
        ),
      );
      return false;
    }
  }

  Future<String> obtenerNombre(User user) async {
    if (user.displayName.toString().isNotEmpty &&
        user.displayName.toString() != "null") {
      return user.displayName.toString();
    } else {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(user.uid.toString())
              .get();
      if (docSnapshot.exists) {
        DocumentUser userDoc = DocumentUser();
        userDoc.fromMap(docSnapshot.data());
        return userDoc.nombre.toString();
      }
    }
    return 'User';
  }

  Future<String> obtenerFoto(User user) async {
    if (user.photoURL.toString().isNotEmpty) {
      return user.photoURL.toString();
    } else {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(user.uid.toString())
              .get();
      if (docSnapshot.exists) {
        DocumentUser userDoc = DocumentUser();
        userDoc.fromMap(docSnapshot.data());
        return userDoc.fotoperfil.toString();
      }
    }
    return 'null';
  }

  Future<List<TrabajosArrendatarios>?> getJobsAndCheckStatusUser() async {
    try {
      QuerySnapshot qs = await FirebaseFirestore.instance
          .collection("TrabajosArrendatarios")
          .get();
      List<TrabajosArrendatarios> documents = qs.docs
          .map((e) => TrabajosArrendatarios(
                actividad: e["actividad"],
                categoria: e["categoria"],
                descripcion: e["descripcion"],
                direccion: e["direccion"],
                email: e["email"],
                fecha: DateTime.parse(e['fecha'].toDate().toString()),
                id: e["id"],
                fotos: e["fotos"],
                precio: e["precio"],
                telefono: e["telefono"],
                titulo: e["titulo"],
                uidArrendador: e["uidArrendador"],
              ))
          .toList();

      //Valida si el usuario es inactivo
      qs = await FirebaseFirestore.instance
          .collection("UsuariosInactivos")
          .where('UserID', isEqualTo: user?.uid)
          .get();
      List<InactiveUser> inactiveUsers = qs.docs
          .map((e) => InactiveUser(
                iUid: e["UserID"],
                visualizacionesGratuitas: e["visualizacionesGratuitas"],
              ))
          .toList();
      if (inactiveUsers.isEmpty) {
        isUserInactive = false;
      } else {
        isUserInactive = true;
      }
      return documents;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> isCurrentUserInactive() async {
    bool result = false;

    QuerySnapshot qs = await FirebaseFirestore.instance
        .collection("UsuariosInactivos")
        .where('UserID', isEqualTo: user!.uid)
        .get();
    List<InactiveUser> inactiveUsers = qs.docs
        .map((e) => InactiveUser(
              iUid: e["UserID"],
              visualizacionesGratuitas: e["VisualizacionesGratuitas"],
            ))
        .toList();
    if (inactiveUsers.isEmpty) {
      result = false;
    } else {
      result = true;
    }
    return result;
  }
}
