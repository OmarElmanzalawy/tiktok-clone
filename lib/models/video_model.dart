import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  String? profilePhoto;

  VideoModel({
    required this.username,
    required this.caption,
    required this.commentCount,
    required this.id,
    required this.likes,
    this.profilePhoto,
    required this.shareCount,
    required this.songName,
    required this.thumbnail,
    required this.uid,
    required this.videoUrl,
  });

  Map<String,dynamic> toJson() => {

    'username': this.username,
    'caption': this.caption,
    'commentcount': this.commentCount,
    'id': this.id,
    'uid': this.uid,
    'likes': this.likes,
    'profilephoto': this.profilePhoto,
    'sharecount': this.shareCount,
    'songname': this.shareCount,
    'thumbnail': this.thumbnail,
    'videourl': this.videoUrl,
  };

factory VideoModel.fromSnap(DocumentSnapshot snap){
Map<String,dynamic> snapshot = snap.data() as Map<String, dynamic>;
return VideoModel(
  username: snapshot['username'] ?? '',
  caption: snapshot['caption'] ?? '',
  commentCount: snapshot['commentcount'] ?? 0,
  id: snapshot['id'],
  uid: snapshot['uid'],
  likes: snapshot['likes'] ?? [],
  profilePhoto: snapshot['profilephoto'],
  shareCount: snapshot['sharecount'],
  songName: snapshot['songname'] ?? '',
  thumbnail: snapshot['thumbnail'],
  videoUrl: snapshot['videourl'],
);
}
}