import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentUser {
  String? id;
  int? alcance;
  String? comuna;
  String? correo;
  String? fotoperfil;
  double? latitud;
  double? longitud;
  String? negocio;
  String? nombre;
  String? telefono;
  String? tipo;
  String? uid;

  DocumentUser(
      {this.id,
      this.uid,
      this.tipo,
      this.latitud,
      this.longitud,
      this.correo,
      this.comuna,
      this.negocio,
      this.telefono,
      this.nombre,
      this.fotoperfil,
      this.alcance});

  Map<String, dynamic> json() {
    return {
      'uid': uid,
      'tipo': tipo,
      'latitud': latitud,
      'longitud': longitud,
      'correo': correo,
      'comuna': comuna,
      'negocio': negocio,
      'telefono': telefono,
      'fotoperfil': fotoperfil,
      'alcance': alcance,
      'nombre': nombre,
    };
  }

  void fromMap(Map? map) {
    id = map?["id"];
    alcance = map?["alcance"];
    comuna = map?["comuna"];
    correo = map?["correo"];
    fotoperfil = map?["fotoperfil"];
    latitud = map?["latitud"];
    longitud = map?["longitud"];
    negocio = map?["negocio"];
    nombre = map?["nombre"];
    telefono = map?["telefono"];
    tipo = map?["tipo"];
    uid = map?["uid"];
  }
}
