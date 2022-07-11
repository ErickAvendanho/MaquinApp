import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../models/trabajos_arrendatario.dart';

class JobDetailController {
  User? user = FirebaseAuth.instance.currentUser;

  Future<TrabajosArrendatario?> getJob(String doc) async {
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
