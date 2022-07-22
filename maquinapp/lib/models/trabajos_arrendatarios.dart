import 'package:cloud_firestore/cloud_firestore.dart';

class TrabajosArrendatarios {
  String? actividad;
  String? categoria;
  String? descripcion;
  String? direccion;
  String? email;
  DateTime? fecha;
  List<dynamic>? fotos;
  String? id;
  String? precio;
  String? telefono;
  String? titulo;
  String? uidArrendador;

  TrabajosArrendatarios(
      {this.actividad,
      this.categoria,
      this.descripcion,
      this.direccion,
      this.email,
      this.fecha,
      this.fotos,
      this.id,
      this.precio,
      this.telefono,
      this.titulo,
      this.uidArrendador});

  CollectionReference users =
      FirebaseFirestore.instance.collection('TrabajosArrendatarios');
  Future<bool> agregarJob(String uidDoc) async {
    bool result = false;
    try {
      users
          .doc(uidDoc)
          .set({
            'actividad': actividad,
            'categoria': categoria,
            'descripcion': descripcion,
            'direccion': direccion,
            'email': email,
            'fecha': fecha,
            'fotos': fotos,
            'id': id,
            'precio': precio,
            'telefono': telefono,
            'titulo': telefono,
            'uidArrendador': uidArrendador
          })
          .then((value) => result = true)
          .catchError((error) => result = false);
      return result;
    } catch (e) {
      return result;
    }
  }

  Map<String, dynamic> json() {
    return {
      'actividad': actividad,
      'categoria': categoria,
      'descripcion': descripcion,
      'direccion': direccion,
      'email': email,
      'fecha': fecha,
      'fotos': fotos,
      'id': id,
      'precio': precio,
      'telefono': telefono,
      'titulo': titulo,
      'uidArrendador': uidArrendador
    };
  }

  void fromMap(Map? map) {
    actividad = map?["actividad"];
    categoria = map?["categoria"];
    descripcion = map?["descripcion"];
    direccion = map?["direccion"];
    email = map?["email"];
    fecha = map?["fecha"];
    fotos = map?["fotos"];
    id = map?["id"];
    precio = map?["precio"];
    telefono = map?["telefono"];
    titulo = map?["titulo"];
    uidArrendador = map?["uidArrendador"];
  }
}
