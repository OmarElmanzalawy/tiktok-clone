import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone2/constants/app_constants.dart';

class TrailingTextfield extends StatelessWidget {
  const TrailingTextfield({super.key, required this.controller, required this.hintText, required this.onTap, this.suffixWidget});

  final TextEditingController controller;
  final String hintText;
  final VoidCallback onTap;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: AppConstants.buttonColor,
      decoration: InputDecoration(
        fillColor: Colors.transparent,
        filled: true,
        hintText: hintText,
        suffixIcon: TextButton(onPressed: onTap,
         child: suffixWidget ?? Text('Send',style: TextStyle(fontSize: 20,color: AppConstants.buttonColor),)
         ),
        labelStyle: const TextStyle( fontSize:  20,),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: AppConstants.backgroundColor)
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppConstants.buttonColor!)
        ),
      ),
    );
  }
}