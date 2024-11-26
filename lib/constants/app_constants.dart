
import 'package:flutter/material.dart';
import 'package:tiktok_clone2/screens/add_video_screen.dart';
import 'package:tiktok_clone2/screens/home_screen.dart';
import 'package:tiktok_clone2/screens/video_screen.dart';
class AppConstants {
  
  static Map<int,Widget> pages ={
    0: VideoScreen(),
    1: Text('Search Screen'),
    2: AddVideoScreen(),
    3: Text('Messages Screen'),
    4: Text('Profile Screen'),
  };

// COLORS
static const backgroundColor = Colors.black;
static final buttonColor = Colors.red[400];
static const borderColor = Colors.grey;


  
}



