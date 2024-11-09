import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String profileUrl;
  final String email;
  final String uid;

  User(
      {required this.email,
      required this.profileUrl,
      required this.uid,
      required this.username});

  Map<String, dynamic> toJson() => {
        'username': username,
        'profilephoto': profileUrl,
        'email': email,
        'uid': uid
      };

  factory User.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        email: snapshot['email'],
        profileUrl: snapshot['profilephoto'],
        uid: snapshot['uid'],
        username: snapshot['username']);
  }
}
