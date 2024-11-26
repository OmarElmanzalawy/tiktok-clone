import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone2/models/video_model.dart';

final retryAttemptProvider = StateProvider<int>((ref) => 0);

final videosStreamProvider = StreamProvider.autoDispose.family<List<VideoModel>,int>((ref,retryAttempt) {
  try{
  return FirebaseFirestore.instance.collection('videos')
  .snapshots().map((snapshot){
          List<VideoModel> videos = [];
          for(var element in snapshot.docs){
                print('FIREBASE DOC: ${element.data()}');
                videos.add(VideoModel.fromSnap(element));
          }

    return videos;
  });
  }
  catch(e){
    print(e);
    throw e;
    
  }
}
);