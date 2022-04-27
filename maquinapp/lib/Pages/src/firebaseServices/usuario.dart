import 'package:firebase_auth/firebase_auth.dart';

class Usuario {
  final String nombre;
  final String uid;

  Usuario(
    this.nombre,
    this.uid,
  );

  String get getNombre => nombre;
  String get getUid => uid;
}
