import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String username;
  final String? profileUrl;
  final String email;
  final String uid;

  UserModel(
      {required this.email,
      this.profileUrl,
      required this.uid,
      required this.username});

  Map<String, dynamic> toJson() => {
        'username': username,
        'profilephoto': profileUrl,
        'email': email,
        'uid': uid
      };

  factory UserModel.fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
        email: snapshot['email'],
        profileUrl: snapshot['profilephoto'],
        uid: snapshot['uid'],
        username: snapshot['username']);
  }
}
