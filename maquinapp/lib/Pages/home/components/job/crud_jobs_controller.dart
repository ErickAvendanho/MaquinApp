import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maquinapp/Pages/src/inactiveUser.dart';
import 'package:maquinapp/models/trabajos_arrendatarios.dart';

class CrudJobsController {
  User? user = FirebaseAuth.instance.currentUser;

  Future<List<TrabajosArrendatarios>?> getLessorJobs() async {
    try {
      QuerySnapshot qs = await FirebaseFirestore.instance
          .collection("TrabajosArrendatarios")
          .where('uidArrendador', isEqualTo: user!.uid)
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
      return documents;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
