import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiktok_clone2/models/comment_model.dart';
import 'package:tiktok_clone2/services/init_getit.dart';
import 'package:tiktok_clone2/services/navigation_service.dart';

class CommentService {


  static postComment(String commentText)async{
    try{
    if(commentText.isNotEmpty){
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      var allDocs = await FirebaseFirestore.instance.collection('videos').doc(_postId).collection('comments').get();
      int len = allDocs.docs.length;

      CommentModel comment = CommentModel(username: (userDoc.data() as dynamic)['username'], comment: commentText.trim(), datePublished: DateTime.now(), id: 'Comment $len', likes: [], profilePhoto: (userDoc.data() as dynamic)['profilephoto'], uid: (userDoc.data() as dynamic)['uid']);

      await FirebaseFirestore.instance.collection('videos').doc(_postId).collection('comments').doc('Comment $len').set(
        comment.toJson()
      );
    }
    }
    catch(e){
      print('ERROR: ${e.toString()}');
    }
  }

}