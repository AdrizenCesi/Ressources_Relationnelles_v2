import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ressources_relationnelles_v1/models/user.dart';

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");

  Future<void> saveUser(String name, String firstname, String email, String role, String bio, String imgProfil, bool modo, bool admin, bool ban) async {
    return await userCollection.doc(uid).set({'name': name, 'email': email, 'firstname' : firstname, 'role' : role, 'bio' : bio, 'imgProfil' : imgProfil, 'modo' : modo, 'admin' : admin, 'ban' : ban});
  }

  Future<void> saveToken(String? token) async {
    return await userCollection.doc(uid).update({'token': token});
  }

  AppUserData _userFromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");
    return AppUserData(
      uid: snapshot.id,
      name: data['name'],
      firstname: data['firstname'],
      email: data['email'],
      role: data['role'],
      bio: data['bio'],
      imgProfil: data['imgProfil'],
      modo: data['modo'],
      admin: data['admin'],
      ban : data['ban']
    );
  }

  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  List<AppUserData> _userListFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _userFromSnapshot(doc);
    }).toList();
  }

  Stream<List<AppUserData>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }
}