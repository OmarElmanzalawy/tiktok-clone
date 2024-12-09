import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {

  Map<String,dynamic> user = {};
  
  String _uid = "";

   Future<void> updateUserId(String uid)async{
    _uid = uid;
    await getUserData();
  }

   getUserData()async{
    List<String> thumbnails = [];
    var myVideos = await FirebaseFirestore.instance.collection('videos')
                             .where('uid',isEqualTo: _uid).get();

    for(var doc in myVideos.docs){
      thumbnails.add((doc.data() as dynamic)['thumbnail']);
    }

    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    final userData = userDoc.data()! as dynamic;

    String name = userData['username'];
    String profilePhoto = userData['profilephoto'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

  for(var doc in myVideos.docs){
    likes += (doc.data()['likes'] as List).length; 
  }

  var followerDoc = await FirebaseFirestore.instance.collection('user').doc(_uid)
                          .collection('followers').get();
  
  var followingDoc = await FirebaseFirestore.instance.collection('user').doc(_uid)
                          .collection('following').get();

  followers = followerDoc.docs.length;
  following = followingDoc.docs.length;

  FirebaseFirestore.instance.collection('users').doc(_uid).collection('followers').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value){
    if(value.exists){
      isFollowing = true;
    }
    else{ 
      isFollowing = false;
    }
  });

  user = {
    'followers': followers.toString(),
    'following': following.toString(),
    'isfollowing': isFollowing,
    'likes': likes.toString(),
    'profilephoto': profilePhoto,
    'username': name,
    'thumbnails': thumbnails
  };

  }

}