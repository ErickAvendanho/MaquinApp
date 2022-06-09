import 'package:cloud_firestore/cloud_firestore.dart';

class TrabajosArrendatario {
  String? descripcion;
  String? fecha;
  String? foto;
  double? latitud;
  double? longitud;
  String? precio;
  String? tipo;
  String? titulo;
  String? uid;
  String? usuario;

  TrabajosArrendatario({
    this.descripcion,
    this.uid,
    this.tipo,
    this.latitud,
    this.longitud,
    this.foto,
    this.fecha,
    this.precio,
    this.titulo,
    this.usuario,
  });

  CollectionReference users =
  FirebaseFirestore.instance.collection('TrabajosArrendatario');
  Future<bool> agregarJob(String uidDoc) async {
    bool result = false;
    try {
      users
          .doc(uidDoc)
          .set({
            'descripcion': descripcion,
            'fecha': fecha,
            'foto': foto,
            'latitud': latitud,
            'longitud': longitud,
            'precio': precio,
            'tipo': tipo,
            'titulo': titulo,
            'uid': uid,
            'usuario': usuario,
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
      'uid': uid,
      'tipo': tipo,
      'latitud': latitud,
      'longitud': longitud,
      'descripcion': descripcion,
      'foto': foto,
      'fecha': fecha,
      'precio': precio,
      'titulo': titulo,
      'usuario': usuario,
    };
  }

  void fromMap(Map? map) {
    descripcion = map?["descripcion"];
    foto = map?["foto"];
    fecha = map?["fecha"];
    precio = map?["precio"];
    titulo = map?["titulo"];
    latitud = map?["latitud"];
    longitud = map?["longitud"];
    usuario = map?["usuario"];
    tipo = map?["tipo"];
    uid = map?["uid"];
  }
}
