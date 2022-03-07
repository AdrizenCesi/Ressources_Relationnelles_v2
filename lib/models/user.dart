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
  final String role;
  final String bio;

  const AppUserData(
      {required this.uid,
      required this.name,
      required this.email,
      required this.firstname,
      required this.role,
      required this.bio,
      });

  factory AppUserData.fromDocument(DocumentSnapshot doc) {
    return AppUserData(
        uid: doc['token'],
        email: doc['email'],
        name: doc['name'],
        firstname: doc['firstname'],
        role: doc['role'],
        bio: doc['bio']
        );
  }
}