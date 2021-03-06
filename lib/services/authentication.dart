import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ressources_relationnelles_v1/services/database.dart';
import 'package:ressources_relationnelles_v1/services/notification.dart';
import '../models/user.dart';


class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final instanceFirestore = FirebaseFirestore.instance.collection("users");

  AppUser? _userFromFirebaseUser(User? user) {
    initUser(user);
    return user != null ? AppUser(user.uid) : null;
  }

  void initUser(User? user) async {
    if (user == null) return;
    NotificationService.getToken().then((value) {
      DatabaseService(user.uid).saveToken(value);
    });
  }

  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String name, String firstname, String email, String password, String role, String bio, String imgProfil, bool modo, bool admin, bool ban) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user == null) {
        throw Exception("No user found");
      } else {
        await DatabaseService(user.uid)
            .saveUser(name, firstname, email, role, bio, imgProfil, modo, admin, ban);

        return _userFromFirebaseUser(user);
      }
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
}