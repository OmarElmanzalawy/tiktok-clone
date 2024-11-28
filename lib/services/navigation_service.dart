import 'package:flutter/material.dart';
import 'package:tiktok_clone2/constants/app_constants.dart';

class NavigationService {

void showSnackbar({SnackBar? customSnackBar,required String text,required context}){

  ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  final snackBar = SnackBar(
    content: Text(text,style: TextStyle(color: Colors.white),),
    backgroundColor: Colors.black,
    );
  ScaffoldMessenger.of(context).showSnackBar(customSnackBar ?? snackBar);
}

Future<void> showBottomSheet(Widget child,BuildContext context)async{
  return await showModalBottomSheet(context: context,
  //isScrollControlled: true,
  backgroundColor: Colors.grey.shade900,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))),
  builder: (context) => Padding(
    padding: EdgeInsets.only(bottom:  MediaQuery.of(context).viewInsets.bottom,),
    child: child,
  )
  );
}

}

class AppColors {
}