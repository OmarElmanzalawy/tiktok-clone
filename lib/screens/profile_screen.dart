import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone2/services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final ProfileService _profileService = ProfileService();

  @override
  void initState() {
    super.initState();
    print('Profile Screen uid: ${widget.uid}');
    _profileService.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
          leading: const Icon(Icons.person_add_alt_1_outlined),
          actions: const [Icon(Icons.more_horiz)],
          title: Text(
            _profileService.user['username'],
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: '',
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator.adaptive(),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Column(
                      children: [
                        Text(
                          '10',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Following',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 25,),
                    Column(
                      children: [
                        Text(
                          '10',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Followers',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 25,),
                    Column(
                      children: [
                        Text(
                          '10',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Likes',
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15,),
                Container(
                  width: 140,
                  height: 47,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12)
                  ),
                  child: Center(
                    child: InkWell(
                    onTap: (){},
                  child: Text('Sign Out',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),),
                )
              ],
            )
          ],
        ));
  }
}
