import 'package:flutter/material.dart';
import 'package:tiktok_clone2/constants/app_constants.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({super.key, required this.controller, required this.labelText, this.isObscure=false, required this.icon});

  final TextEditingController controller;
  final String labelText;
  final bool isObscure;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        labelStyle: const TextStyle( fontSize:  20,),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: AppConstants.borderColor)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: AppConstants.borderColor)
        ),
      ),
      obscureText:  isObscure,
    );
  }
}