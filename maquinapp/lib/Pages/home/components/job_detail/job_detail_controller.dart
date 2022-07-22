import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maquinapp/Pages/src/inactiveUser.dart';

import '../../../../models/trabajos_arrendatarios.dart';

class JobDetailController {
  User? user = FirebaseAuth.instance.currentUser;
  late InactiveUser inactiveUser;
  late bool hasFreeViewsYet;
  late int freeViews;

  Future<TrabajosArrendatarios?> getJobAndInfoInactiveUser(
      String doc, bool isLogued, bool isUserInactive) async {
    if (isLogued) {
      if (isUserInactive) {
        try {
          DocumentSnapshot<Map<String, dynamic>> docSnapshot =
              await FirebaseFirestore.instance
                  .collection("TrabajosArrendatarios")
                  .doc(doc)
                  .get();
          TrabajosArrendatarios jobDoc = TrabajosArrendatarios();
          jobDoc.actividad = docSnapshot["actividad"];
          jobDoc.categoria = docSnapshot["categoria"];
          jobDoc.descripcion = docSnapshot["descripcion"];
          jobDoc.direccion = docSnapshot["direccion"];
          jobDoc.email = docSnapshot["email"];
          jobDoc.fecha =
              DateTime.parse(docSnapshot['fecha'].toDate().toString());
          jobDoc.fotos = docSnapshot["fotos"];
          jobDoc.id = docSnapshot["id"];
          jobDoc.precio = docSnapshot["precio"];
          jobDoc.telefono = docSnapshot["telefono"];
          jobDoc.titulo = docSnapshot["titulo"];
          jobDoc.uidArrendador = docSnapshot["uidArrendador"];

          //Obtiene información del usuario inactivo
          QuerySnapshot qs = await FirebaseFirestore.instance
              .collection("UsuariosInactivos")
              .where('UserID', isEqualTo: user!.uid)
              .get();
          List<InactiveUser> inactiveUsers = qs.docs
              .map((e) => InactiveUser(
                    iUid: e["UserID"],
                    visualizacionesGratuitas: e["visualizacionesGratuitas"],
                  ))
              .toList();

          inactiveUser = inactiveUsers.first;
          freeViews = inactiveUser.visualizacionesGratuitas;

          //Revisa si el usuario inactivo aún tiene entre 1 y 3 visualizaciones gratuitas
          if (freeViews >= 1 && freeViews <= 3) {
            hasFreeViewsYet = true;
          } else {
            hasFreeViewsYet = false;
          }
          return jobDoc;
        } catch (e) {
          print(e);
          return null;
        }
      } else {
        try {
          DocumentSnapshot<Map<String, dynamic>> docSnapshot =
              await FirebaseFirestore.instance
                  .collection("TrabajosArrendatarios")
                  .doc(doc)
                  .get();
          TrabajosArrendatarios jobDoc = TrabajosArrendatarios();
          jobDoc.actividad = docSnapshot["actividad"];
          jobDoc.categoria = docSnapshot["categoria"];
          jobDoc.descripcion = docSnapshot["descripcion"];
          jobDoc.direccion = docSnapshot["direccion"];
          jobDoc.email = docSnapshot["email"];
          jobDoc.fecha =
              DateTime.parse(docSnapshot['fecha'].toDate().toString());
          jobDoc.fotos = docSnapshot["fotos"];
          jobDoc.id = docSnapshot["id"];
          jobDoc.precio = docSnapshot["precio"];
          jobDoc.telefono = docSnapshot["telefono"];
          jobDoc.titulo = docSnapshot["titulo"];
          jobDoc.uidArrendador = docSnapshot["uidArrendador"];
          return jobDoc;
        } catch (e) {
          print(e);
          return null;
        }
      }
    } else {
      try {
        DocumentSnapshot<Map<String, dynamic>> docSnapshot =
            await FirebaseFirestore.instance
                .collection("TrabajosArrendatarios")
                .doc(doc)
                .get();
        TrabajosArrendatarios jobDoc = TrabajosArrendatarios();
        jobDoc.actividad = docSnapshot["actividad"];
        jobDoc.categoria = docSnapshot["categoria"];
        jobDoc.descripcion = docSnapshot["descripcion"];
        jobDoc.direccion = docSnapshot["direccion"];
        jobDoc.email = docSnapshot["email"];
        jobDoc.fecha = DateTime.parse(docSnapshot['fecha'].toDate().toString());
        jobDoc.fotos = docSnapshot["fotos"];
        jobDoc.id = docSnapshot["id"];
        jobDoc.precio = docSnapshot["precio"];
        jobDoc.telefono = docSnapshot["telefono"];
        jobDoc.titulo = docSnapshot["titulo"];
        jobDoc.uidArrendador = docSnapshot["uidArrendador"];
        return jobDoc;
      } catch (e) {
        print(e);
        return null;
      }
    }
  }

  Future<bool> actulizarUsuarioInactivo(
      String iUid, int visualizacionesGratuitas) async {
    bool result = false;
    final db =
        FirebaseFirestore.instance.collection('UsuariosInactivos').doc(iUid);
    try {
      await db
          .update({'visualizacionesGratuitas': visualizacionesGratuitas})
          .then((value) => result = true)
          .catchError((error) => result = false);
      return result;
    } catch (e) {
      return result;
    }
  }
}
