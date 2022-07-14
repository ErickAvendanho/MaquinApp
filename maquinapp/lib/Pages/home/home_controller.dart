import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maquinapp/Pages/src/inactiveUser.dart';

import '../../models/document_user.dart';
import '../../models/trabajos_arrendatario.dart';

class HomeController {
  late List<Marker>? markers;
  late bool isUserInactive;
  User? user = FirebaseAuth.instance.currentUser;
  Future<bool> addMarkers() async {
    try {
      QuerySnapshot qs = await FirebaseFirestore.instance
          .collection("TrabajosArrendatario")
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

  Future<List<TrabajosArrendatario>?> getJobsAndCheckStatusUser() async {
    try {
      QuerySnapshot qs = await FirebaseFirestore.instance
          .collection("TrabajosArrendatario")
          .get();
      List<TrabajosArrendatario> documents = qs.docs
          .map((e) => TrabajosArrendatario(
                descripcion: e["descripcion"],
                uid: e["uid"],
                fecha: e["fecha"],
                tipo: e["tipo"],
                longitud: e["longitud"],
                latitud: e["latitud"],
                precio: e["precio"],
                foto: e["foto"],
                titulo: e["titulo"],
                usuario: e["usuario"],
              ))
          .toList();

      //Valida si el usuario es inactivo
      qs = await FirebaseFirestore.instance
          .collection("UsuariosInactivos")
          .where('UserID', isEqualTo: user!.uid)
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
