import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone2/constants/app_constants.dart';
import 'package:tiktok_clone2/providers/navigation_bar_index.dart';
import 'package:tiktok_clone2/widgets/custom_navigation_bar_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final navIndex = ref.watch(navigationBarIndexProvider);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,size: 30,),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search,size: 30,),label: 'Search'),
          BottomNavigationBarItem(icon: CustomNavigationBarItem(),label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.message,size: 30,),label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person,size: 30,),label: 'Profile'),
        ],
        onTap: (value){
          ref.read(navigationBarIndexProvider.notifier).updateValue(value);
        },
        ),
      body: Center(
        child: AppConstants.pages[navIndex],
      ),
    );
  }
}