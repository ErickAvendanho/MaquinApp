import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser {
  final int alcance;
  final String comuna;
  final String correo;
  final String fotoPerfil;
  final double latitud;
  final double longitud;
  final String negocio;
  final String nombre;
  final String privilegios;
  final String telefono;
  final String tipo;
  final String uid;
  final String status;
  final String? actividad;
  final String? categoria;

  AddUser(
      this.alcance,
      this.comuna,
      this.correo,
      this.fotoPerfil,
      this.latitud,
      this.longitud,
      this.negocio,
      this.nombre,
      this.privilegios,
      this.telefono,
      this.tipo,
      this.uid,
      this.status,
      this.actividad,
      this.categoria);
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference inactiveUsers =
      FirebaseFirestore.instance.collection('UsuariosInactivos');

  Future<bool> agregarUsuarioFirestoreDocRandom() async {
    bool result = false;
    try {
      users
          .add({
            'alcance': alcance,
            'comuna': comuna,
            'correo': correo,
            'fotoperfil': fotoPerfil,
            'latitud': latitud,
            'longitud': longitud,
            'negocio': negocio,
            'nombre': nombre,
            'telefono': telefono,
            'tipo': tipo,
            'uid': uid,
            'status': status,
            'actividad': actividad,
            'categoria': categoria
          })
          .then((value) => result = true)
          .catchError((error) => result = false);
      return result;
    } catch (e) {
      return result;
    }
  }

  Future<bool> agregarUsuarioFirestore(bool esArrendatario) async {
    bool result = false;
    try {
      if(esArrendatario){
        users
          .doc(uid.toString())
          .set({
            'alcance': alcance,
            'comuna': comuna,
            'correo': correo,
            'fotoperfil': fotoPerfil,
            'latitud': latitud,
            'longitud': longitud,
            'negocio': negocio,
            'nombre': nombre,
            'telefono': telefono,
            'tipo': tipo,
            'uid': uid,
            'status': status,
            'actividad': actividad,
            'categoria': categoria
          })
          .then((value) => result = true)
          .catchError((error) => result = false);
      }else{
        users
          .doc(uid.toString())
          .set({
            'alcance': alcance,
            'comuna': comuna,
            'correo': correo,
            'fotoperfil': fotoPerfil,
            'latitud': latitud,
            'longitud': longitud,
            'negocio': negocio,
            'nombre': nombre,
            'telefono': telefono,
            'tipo': tipo,
            'uid': uid,
            'status': status
          })
          .then((value) => result = true)
          .catchError((error) => result = false);
      }
      
      if (status == 'inactivo') {
        inactiveUsers
            .doc(uid.toString())
            .set({'UserID': uid, 'visualizacionesGratuitas': 3})
            .then((value) => result = true)
            .catchError((error) => result = false);
      }
      return result;
    } catch (e) {
      return result;
    }
  }
}
