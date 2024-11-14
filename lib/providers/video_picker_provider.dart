
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone2/screens/confirm_video_screen.dart';

final videoPickerProvider = StateNotifierProvider<VideoPickerNotifier,File?>((ref) {
  return VideoPickerNotifier();
});

class VideoPickerNotifier extends StateNotifier<File?> {
  VideoPickerNotifier(): super(null);
  
  pickVideo(ImageSource src,BuildContext context)async{
    final video = await ImagePicker().pickVideo(source: src);
    if(video != null){
      state = File(video.path);
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ConfirmVideoScreen(state!, video.path)));
    }
  }


}