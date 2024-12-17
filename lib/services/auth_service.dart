import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone2/models/user.dart';
import 'package:tiktok_clone2/services/init_getit.dart';
import 'package:tiktok_clone2/services/navigation_service.dart';

class AuthService  {

  static Future<String> _uploadToStorage(File image)async{
    Reference reference = FirebaseStorage.instance.ref().child('profilePics').child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }



  static Future<void> registerUser({required String username,required String email,required String password, File? image })async{
    try{
      if(username.isNotEmpty && email.isNotEmpty && password.isNotEmpty){
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    String? downloadUrl = image != null ?  await _uploadToStorage(image) : null;
    UserModel user = UserModel(email: email, profileUrl: downloadUrl, uid: userCredential.user!.uid, username: username);
    await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set(user.toJson());
      }
      else{

      }
    }
    catch(e){
      //Display snackbar
      print('Error: ${e.toString()}');
    }
  }

    static void loginUser({required String email,required String password,required context})async{
    try{
      if(email.isNotEmpty && password.isNotEmpty){
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        Navigator.pushReplacementNamed(context,'/home');
        print('Login Success');
      }
      else{
        //TODO: Fix Snackbars
        getIt<NavigationService>().showSnackbar(text: 'Login Success!', context: context);
      }
    }
    catch(e){
      //Display snackbar
      print('Error: ${e.toString()}');
    }
  }

  static Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
  }

}