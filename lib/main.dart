import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone2/firebase_options.dart';
import 'package:tiktok_clone2/screens/add_video_screen.dart';
import 'package:tiktok_clone2/screens/auth/login_screen.dart';
import 'package:tiktok_clone2/screens/auth/register_screen.dart';
import 'package:tiktok_clone2/screens/confirm_video_screen.dart';
import 'package:tiktok_clone2/screens/home_screen.dart';
import 'package:tiktok_clone2/screens/profile_screen.dart';
import 'package:tiktok_clone2/services/init_getit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value){
    
    }
  );
  print('Firebase Initialized');
  //For debugging only untill logout is implemented
  //await FirebaseAuth.instance.signOut();
  //print('CURRENT USER ID: ${FirebaseAuth.instance.currentUser!.uid}');
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        splashFactory: NoSplash.splashFactory,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          
          //backgroundColor: Colors.grey
        ),
      ),
      title: 'Tiktok Clone',
      debugShowCheckedModeBanner: false,

      initialRoute: FirebaseAuth.instance.currentUser == null ? '/login' : '/home',

      routes: {
        '/signup': (context) => SignupScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/addvideo': (context) => AddVideoScreen(),
        '/profile' : (context) => ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid)
      },
      
    );
  }
}
