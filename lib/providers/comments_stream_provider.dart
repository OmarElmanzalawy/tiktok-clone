import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone2/models/comment_model.dart';
import 'package:tiktok_clone2/models/video_model.dart';
import 'package:tiktok_clone2/services/comment_service.dart';

final commentsStreamProvider = StreamProvider.autoDispose<List<CommentModel>>((ref) {
  try{
  final postId = CommentService.getPostId;
  print('PROVIDER POST ID: $postId');
  
  return FirebaseFirestore.instance
      .collection('videos')
      .doc(postId)
      .collection('Comments')
      .snapshots()
      .map((QuerySnapshot query) {
    // Map each document in the snapshot to a CommentModel
    return query.docs.map((doc) => CommentModel.fromSnap(doc)).toList();
  });
  }
  catch(e){
    throw e;
  }
});