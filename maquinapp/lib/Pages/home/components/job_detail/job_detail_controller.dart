import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maquinapp/Pages/src/inactiveUser.dart';

import '../../../../models/trabajos_arrendatario.dart';

class JobDetailController {
  User? user = FirebaseAuth.instance.currentUser;
  late InactiveUser inactiveUser;
  late bool hasFreeViewsYet;
  late int freeViews;

  Future<TrabajosArrendatario?> getJobAndInfoInactiveUser(
      String doc, bool isLogued) async {
    if (isLogued) {
      try {
        DocumentSnapshot<Map<String, dynamic>> docSnapshot =
            await FirebaseFirestore.instance
                .collection("TrabajosArrendatario")
                .doc(doc)
                .get();
        TrabajosArrendatario jobDoc = TrabajosArrendatario();
        jobDoc.fromMap(docSnapshot.data());

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
        return null;
      }
    }else{
      try {
        DocumentSnapshot<Map<String, dynamic>> docSnapshot =
            await FirebaseFirestore.instance
                .collection("TrabajosArrendatario")
                .doc(doc)
                .get();
        TrabajosArrendatario jobDoc = TrabajosArrendatario();
        jobDoc.fromMap(docSnapshot.data());
        return jobDoc;
      } catch (e) {
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
