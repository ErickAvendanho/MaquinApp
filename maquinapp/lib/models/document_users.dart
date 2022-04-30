import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentUsers {
  String? id;
  int alcance;
  String comuna;
  String correo;
  String? fotoperfil;
  double latitud;
  double longitud;
  String negocio;
  String nombre;
  String telefono;
  String tipo;
  String uid;

  DocumentUsers(
      {this.id,
      required this.uid,
      required this.tipo,
      required this.latitud,
      required this.longitud,
      required this.correo,
      required this.comuna,
      required this.negocio,
      required this.telefono,
      required this.nombre,
      this.fotoperfil,
      required this.alcance});

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

  DocumentUsers.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        uid = doc.data()!["uid"],
        tipo = doc.data()!["tipo"],
        latitud = doc.data()!["latitud"],
        longitud = doc.data()!["longitud"],
        correo = doc.data()!["correo"],
        comuna = doc.data()!["comuna"],
        negocio = doc.data()!["negocio"],
        telefono = doc.data()!["telefono"],
        fotoperfil = doc.data()!["fotoperfil"],
        alcance = doc.data()!["alcance"],
        nombre = doc.data()!["nombre"];
}
