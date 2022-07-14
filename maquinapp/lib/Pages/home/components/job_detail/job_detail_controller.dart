import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maquinapp/Pages/src/inactiveUser.dart';

import '../../../../models/trabajos_arrendatario.dart';

class JobDetailController {
  User? user = FirebaseAuth.instance.currentUser;
  late InactiveUser inactiveUser;

  Future<TrabajosArrendatario?> getJobAndInfoInactiveUser(String doc) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> docSnapshot =
          await FirebaseFirestore.instance
              .collection("TrabajosArrendatario")
              .doc(doc)
              .get();
      TrabajosArrendatario jobDoc = TrabajosArrendatario();
      jobDoc.fromMap(docSnapshot.data());

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

      return jobDoc;
    } catch (e) {
      return null;
    }
  }
}
