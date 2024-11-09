import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone2/firebase_options.dart';
import 'package:tiktok_clone2/screens/auth/register_screen.dart';
import 'package:tiktok_clone2/services/init_getit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((value){
    
    }
  );
  print('Firebase Initialized');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiktok Clone',
      debugShowCheckedModeBanner: false,
      home: SignupScreen(),
    );
  }
}
