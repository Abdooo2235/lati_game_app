import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lati_game_app/providers/base_provider.dart';

class AuthenticationProvider extends BaseProvider {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool loading = false;
  Future<bool> login(String email, String password) async {
    setBusy(true);
    UserCredential userCred = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    if (userCred.user != null) {
      setBusy(false);

      // Save user data and return true if successful
      return true;
    } else {
      setBusy(false);

      return false;
    }
  }

  Future<bool> createAccount(String email, String password) async {
    UserCredential userCred = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (userCred.user != null) {
      FirebaseFirestore Firestore = FirebaseFirestore.instance;
      Firestore.collection("users")add(
        "email": email,
        "user_uid": userCred.user.user!.uid);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> logout() async {
    firebaseAuth.signOut();
    return true;
  }
}
