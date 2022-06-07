import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../models/trabajos_arrendatario.dart';

class JobDetailController {
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
