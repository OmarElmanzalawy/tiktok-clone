import 'package:flutter/material.dart';

class NavigationService {

void showSnackbar({SnackBar? customSnackBar,required String text,required context}){

  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  final snackBar = SnackBar(
    content: Text(text,style: TextStyle(color: Colors.white),),
    backgroundColor: Colors.black,
    );
  ScaffoldMessenger.of(context).showSnackBar(customSnackBar ?? snackBar);
}

}

class AppColors {
}