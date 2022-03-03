import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String uid;

  AppUser(this.uid);
}

class AppUserData {
  final String uid;
  final String name;
  final String firstname;
  final String email;

  const AppUserData({
    required this.uid,
    required this.name,
    required this.firstname,
    required this.email,
  });

  factory AppUserData.fromDocument(DocumentSnapshot doc) {
    return AppUserData(
        uid: doc['uid'],
        name: doc['name'],
        firstname: doc['firstname'],
        email: doc['email']);
  }
}
