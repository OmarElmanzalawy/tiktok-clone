import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoService {

  uploadvideo(String songName,String caption,String videoPath)async{

     _compressVideo(String videoPath)async{
      final compressedVideo = await VideoCompress.compressVideo(
        videoPath,
        quality: VideoQuality.MediumQuality,
      );
      return compressedVideo!.file;
    }

    Future<String> _uploadVideoToStorage(String id,String videopath)async{
      Reference ref = FirebaseStorage.instance.ref().child('videos').child(id);
      File? compressedVideo =  await _compressVideo(videoPath);
    UploadTask? uploadTask =  compressedVideo!= null ? ref.putFile(compressedVideo) : null;
      TaskSnapshot? snap = uploadTask!=null ? await uploadTask : null;
      String downloadUrl = await snap!.ref.getDownloadURL();
      return downloadUrl;
    }

    _getThumbnail(String videoPath)async{
      final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
      return thumbnail;
    }

    Future<String> _uploadThumbnailToStorage(String id,String videoPath)async{
      Reference ref = FirebaseStorage.instance.ref().child('thumbnails').child(id);
      UploadTask uploadTask =  ref.putFile(await _getThumbnail(videoPath));
      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      return downloadUrl;
    }

    try{
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      var allDocs = await FirebaseFirestore.instance.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage("Video $len",videoPath);
      String thumbnail = await _uploadThumbnailToStorage("Video $len", videoPath);
    }
    catch(e){

    }
  }

}