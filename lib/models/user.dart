import 'package:firebase_database/firebase_database.dart';

class MyUser {
  String uid='';
  String firstname='';
  String lastname='';
  String imageUrl='';
  String letters=''; // initiales

  MyUser(DataSnapshot snapshot) {
    uid = snapshot.key!;


    Map<String, String> map = snapshot.value as Map<String, String>;
    firstname = map['firstname']!;
    lastname = map['lastname']!;
    imageUrl = map['imageUrl']!;

    if (firstname.isNotEmpty) {
      letters = firstname[0];
    }

    if (lastname.isNotEmpty) {
      letters += lastname[0];
    }
  }

  Map<String, String?> toMap() {
    return {
      "uid": "uid",
      "firstname": firstname,
      "lastname": lastname,
      "letters": letters,
      "imageUrl": imageUrl,
    };
  }

}