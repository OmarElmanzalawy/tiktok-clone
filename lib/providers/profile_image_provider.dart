import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final profilePictureProvider = StateNotifierProvider<ProfileImageNotifier,File?>((ref) {
  return ProfileImageNotifier();
});

class ProfileImageNotifier extends StateNotifier<File?> {
  ProfileImageNotifier(): super(null);
  
       Future<void> pickImage()async{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage !=null){
      //Display snackbar
    }
    state = File(pickedImage!.path);
  }


}