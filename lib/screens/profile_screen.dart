import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone2/constants/app_constants.dart';
import 'package:tiktok_clone2/providers/profile_user_provider.dart';
import 'package:tiktok_clone2/services/profile_service.dart';

class ProfileScreen extends ConsumerWidget {
  final String uid;
  ProfileScreen({super.key, required this.uid});

  final ProfileService _profileService = ProfileService();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final profileState = ref.watch(profileProvider(uid));
    print('Fetching profile for uid: $uid');
    // print(profileState.value.toString());
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.black12,
        //   leading: const Icon(Icons.person_add_alt_1_outlined),
        //   actions: const [Icon(Icons.more_horiz)],
        //   title: Text(
        //     _profileService.user['username'],
        //     style: const TextStyle(
        //         fontWeight: FontWeight.bold, color: Colors.white),
        //   ),
        //   centerTitle: true,
        // ),
        body: profileState.when(
        
        loading: () {
           return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },

        error: (error, stackTrace) {
          const Center(
            child: Text('Couldn\'t load profile.Try again later',style: TextStyle(color: Colors.white),)
          );
        },

        data: (data) {
          return Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: data['profilephoto'] ?? AppConstants.defaultProfileImage,
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
        );
        },

        ) );
  }
}
