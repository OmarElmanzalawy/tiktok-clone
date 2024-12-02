import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tiktok_clone2/models/comment_model.dart';
import 'package:tiktok_clone2/services/init_getit.dart';
import 'package:tiktok_clone2/services/navigation_service.dart';

class CommentService {

  static String _postId = "";
  static String get getPostId => _postId;
  

  static void updatePostId(String id){
    
    _postId = id;
  }



  static Future<void> postComment(String commentText)async{
    try{
    if(commentText.isNotEmpty){
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      var allDocs = await FirebaseFirestore.instance.collection('videos').doc(_postId).collection('comments').get();
      var videoDoc = await FirebaseFirestore.instance.collection('videos').doc(_postId).get();
      final videoData = videoDoc.data();
      await FirebaseFirestore.instance.collection('videos').doc(_postId).update(
        {
        'commentcount': videoData!['commentcount'] + 1
        }
      );
      int len = videoData!['commentcount'];
        
      print('LEN ${len.toString()}');

      CommentModel comment = CommentModel(username: (userDoc.data() as dynamic)['username'], comment: commentText.trim(), datePublished: DateTime.now(), id: 'Comment $len', likes: [], profilePhoto: (userDoc.data() as dynamic)['profilephoto'], uid: (userDoc.data() as dynamic)['uid']);

      await FirebaseFirestore.instance.collection('videos').doc(_postId).collection('Comments').doc('Comment ${len}').set(
        comment.toJson()
      );
    }
    }
    catch(e){
      print('ERROR: ${e.toString()}');
      //throw e;
    }
  }

  static Future<void> likeComment(String id)async{
    var uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('videos').doc(_postId).collection('Comments').doc(id).get();

    if((doc.data()! as dynamic)['likes'].contains(uid)){
      FirebaseFirestore.instance.collection('videos').doc(_postId).collection('Comments').doc(id).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    }
    else{
      FirebaseFirestore.instance.collection('videos').doc(_postId).collection('Comments').doc(id).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }

}