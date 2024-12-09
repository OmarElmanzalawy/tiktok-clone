import 'package:flutter/material.dart';
import 'package:tiktok_clone2/constants/app_constants.dart';
import 'package:tiktok_clone2/models/user.dart';
import 'package:tiktok_clone2/services/search_service.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<UserModel> searchedUsers= []; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: TextFormField(
          decoration: const InputDecoration(
            filled: false,
            hintText: 'Search',
            hintStyle: TextStyle(fontSize: 18,color: Colors.white),
          ),
          onFieldSubmitted: (value) async { 
            searchedUsers = await SearchService.searchUser(value);
            setState(() {
              
            });
            },
        ),
      ),
      body: searchedUsers.isEmpty ? 
      Center(child: const Text('No Users Found',style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w600),))
      :
      ListView.builder(
        itemCount: searchedUsers.length,
        itemBuilder: (context,index){
          UserModel user = searchedUsers[index];
          return InkWell(
            onTap: (){},
            child: ListTile(
              leading:   CircleAvatar(backgroundImage: user.profileUrl == null ? const NetworkImage('https://static.vecteezy.com/system/resources/thumbnails/020/765/399/small_2x/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg') :NetworkImage(user.profileUrl!),),
              title: Text(user.username, style: const TextStyle(fontSize: 18,color: Colors.white),),
            ),
          );
        }
        )
    );
  }
}
