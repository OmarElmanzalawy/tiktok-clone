import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone2/widgets/comment_widget.dart';

class CommentModel {

  String username;
  String comment;
  final datePublished;
  List likes;
  String? profilePhoto;
  String uid;
  String id;

  CommentModel({
    required this.username,
    required this.comment,
    required this.datePublished,
    required this.id,
    required this.likes,
    this.profilePhoto,
    required this.uid,
  });

  Map<String,dynamic> toJson() => {
    'username': username,
    'comment': comment,
    'datepublished': datePublished,
    'likes': likes,
    'profilephoto': profilePhoto,
    'uid': uid,
    'id': id,
  };

  static CommentModel fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String,dynamic>;

    return CommentModel(
      username: snapshot['username'],
      comment: snapshot['comment'],
      datePublished: snapshot['datepublished'],
      likes: snapshot['likes'],
      profilePhoto: snapshot['profilephoto'],
      uid: snapshot['uid'],
      id: snapshot['id'],
    );
  }

}