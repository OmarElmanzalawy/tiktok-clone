import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {

  Map<String,dynamic> user = {};
  
  String _uid = "";

   Future<Map<String,dynamic>?> updateUserId(String uid)async{
    _uid = uid;
    final user = await getUserData();
    return user;
  }

   Future<Map<String,dynamic>?> getUserData()async{
    List<String> thumbnails = [];
    var myVideos = await FirebaseFirestore.instance.collection('videos')
                             .where('uid',isEqualTo: _uid).get();

    for(var doc in myVideos.docs){
      thumbnails.add((doc.data() as dynamic)['thumbnail']);
    }

    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    final userData = userDoc.data()! as dynamic;

    String name = userData['username'];
    String? profilePhoto = userData['profilephoto'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

  for(var doc in myVideos.docs){
    likes += (doc.data()['likes'] as List).length; 
  }

  var followerDoc = await FirebaseFirestore.instance.collection('users').doc(_uid)
                          .collection('followers').get().catchError((e){
    print('Couldn\'t fetch followers document');
  });;
  
  var followingDoc = await FirebaseFirestore.instance.collection('users').doc(_uid)
                          .collection('following').get().catchError((e){
    print('Couldn\'t fetch following document');
  });;

  followers = followerDoc.docs.length;
  following = followingDoc.docs.length;

  await FirebaseFirestore.instance.collection('users').doc(_uid).collection('followers').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value){
    if(value.exists){
      isFollowing = true;
    }
    else{ 
      isFollowing = false;
    }
  }).catchError((e){
    print('Couldn\'t fetch followers document');
  });

  print('USER: $user');

  user = {
    'followers': followers.toString(),
    'following': following.toString(),
    'isfollowing': isFollowing,
    'likes': likes.toString(),
    'profilephoto': profilePhoto,
    'username': name,
    'thumbnails': thumbnails
  };
  return user;
    }

   Future<void> followUser()async{
    var doc = await FirebaseFirestore.instance.collection('users')
    .doc(_uid).collection('followers').doc(FirebaseAuth.instance.currentUser!.uid).get();

    if(!doc.exists){
      print('Already Following');
      await FirebaseFirestore.instance.collection('users').doc(_uid).collection('followers').doc(FirebaseAuth.instance.currentUser!.uid)
      .set({});

       await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('following').doc(_uid)
      .set({});
      //Increase followers by 1
      user.update('followers', (value) => (int.parse(value) + 1).toString());
    }
    else{
      print('Not Following');
      await FirebaseFirestore.instance.collection('users').doc(_uid).collection('followers').doc(FirebaseAuth.instance.currentUser!.uid)
      .delete();

       await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('following').doc(_uid)
      .delete();
      //Increase followers by 1
      user.update('followers', (value) => (int.parse(value) - 1).toString());

    }
    user.update('isfollowing', (value)=> !value);
    
    
  }

  }
