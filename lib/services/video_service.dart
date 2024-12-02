import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class VideoService {

  static Future<void> likeVideo(String id)async{
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('videos').doc(id).get();
    var uid = FirebaseAuth.instance.currentUser!.uid;

    if((doc.data() as dynamic)['likes'].contains(uid)){

      await FirebaseFirestore.instance.collection('videos').doc(id).update(
        {
        'likes': FieldValue.arrayRemove([uid])
        }
      ).then((_)=> print('Like removed')).catchError((error)=> throw error);
    }
    else{
      await FirebaseFirestore.instance.collection('videos').doc(id).update(
        {
        'likes': FieldValue.arrayUnion([uid])
        }
      ).then((_)=> print('Like Added')).catchError((error)=> throw error);
    }
  }
}