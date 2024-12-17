
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone2/screens/add_video_screen.dart';
import 'package:tiktok_clone2/screens/home_screen.dart';
import 'package:tiktok_clone2/screens/profile_screen.dart';
import 'package:tiktok_clone2/screens/search_screen.dart';
import 'package:tiktok_clone2/screens/video_screen.dart';
class AppConstants {
  
  static Map<int,Widget> pages ={
    0: VideoScreen(),
    1: SearchScreen(),
    2: AddVideoScreen(),
    3: Text('Messages Screen'),
    4: ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,),
  };

 static const String defaultProfileImage = 'https://e7.pngegg.com/pngimages/981/645/png-clipart-default-profile-united-states-computer-icons-desktop-free-high-quality-person-icon-miscellaneous-silhouette.png';

// COLORS
static const backgroundColor = Colors.black;
static final buttonColor = Colors.red[400];
static const borderColor = Colors.grey;
static const defaultProfileIcon = Icons.account_circle;


  
}



