import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential?> singIn(String mail, String password) async {
    UserCredential? userCredential;
    try {
      userCredential = await _auth.signInWithEmailAndPassword(
          email: mail, password: password);
      print('------------------------');
      print(userCredential);
      print('------------------------');
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return null;
      } else if (e.code == 'wrong-password') {
        return null;
      }
    }
  }

  Future<bool> registration(String mail, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return false;
      } else if (e.code == 'email-already-in-use') {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return true;
  }
}
