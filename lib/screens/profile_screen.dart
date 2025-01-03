import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone2/constants/app_constants.dart';
import 'package:tiktok_clone2/providers/profile_user_provider.dart';
import 'package:tiktok_clone2/services/auth_service.dart';
import 'package:tiktok_clone2/services/profile_service.dart';

class ProfileScreen extends ConsumerWidget {
  final String uid;
  ProfileScreen({super.key, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider(uid));
    // print('PROFILE STATE: $profileState');
    // print(profileState.value.toString());
    return Scaffold(
        appBar: profileState.hasError || profileState.isLoading
            ? null
            : AppBar(
                backgroundColor: Colors.black12,
                actions: const [Icon(Icons.more_horiz)],
                title: Text(
                  profileState.value!['username'],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                centerTitle: true,
              ),
        body: profileState.when(
          loading: () {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          },
          error: (error, stackTrace) {
            const Center(
                child: Text(
              'Couldn\'t load profile.Try again later',
              style: TextStyle(color: Colors.white),
            ));
          },
          data: (data) {
             uid != FirebaseAuth.instance.currentUser!.uid ?  print('Is following: ${data['isfollowing']}') : print('same user');
            return Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: data['profilephoto'] ??
                                AppConstants.defaultProfileImage,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              data['following'],
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
                        const SizedBox(
                          width: 25,
                        ),
                        Column(
                          children: [
                            Text(
                              data['followers'],
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
                        const SizedBox(
                          width: 25,
                        ),
                        Column(
                          children: [
                            Text(
                              data['likes'],
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
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 140,
                      height: 47,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12)),
                      child: Center(
                        child: InkWell(
                            onTap: ()async {
                              if(uid == FirebaseAuth.instance.currentUser!.uid ){
                                await AuthService.signOut();
                                Navigator.pushReplacementNamed(context, '/login');
                              }
                              else{
                                await ref.read(profileProvider(uid).notifier).toggleFollowStatus();
                              }
                            },
                            child: Text(
                              uid == FirebaseAuth.instance.currentUser!.uid 
                              ?
                              'Sign Out'
                              :
                              data['isfollowing'] == true ?  'Unfollow' : 'Follow',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),

                  ],
                ),
                GridView.builder(
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: data['thumbnails'].length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 5,
                    ),
                   itemBuilder: (context,index){
                    String thumbnail = data['thumbnails'][index];
                    return CachedNetworkImage(imageUrl: thumbnail,fit: BoxFit.cover,);
                   })
              ],
            );
          },
        ));
  }
}
