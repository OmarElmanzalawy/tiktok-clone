import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone2/providers/videos_stream_provider.dart';
import 'package:tiktok_clone2/services/init_getit.dart';
import 'package:tiktok_clone2/services/navigation_service.dart';
import 'package:tiktok_clone2/services/video_service.dart';
import 'package:tiktok_clone2/widgets/circle_animation.dart';
import 'package:tiktok_clone2/widgets/dialogs/comments_dialog.dart';
import 'package:tiktok_clone2/widgets/error_widget.dart';
import 'package:tiktok_clone2/widgets/music_album.dart';
import 'package:tiktok_clone2/widgets/video_player_item.dart';

class VideoScreen extends ConsumerWidget {
  final PageController pageController = PageController(viewportFraction: 1);
  VideoScreen({super.key});

  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            child: Container(
              width: 50,
              height: 50,
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image(
                    image: NetworkImage(profilePhoto),
                    fit: BoxFit.cover,
                  )),
            ),
          )
        ],
      ),
    );
  }

  bool isVideoLiked = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final retryAttempt = ref.watch(retryAttemptProvider);
    final videoStream = ref.watch(videosStreamProvider(retryAttempt));
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: videoStream.when(
      data: (videosList) => PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: videosList.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                VideoPlayerItem(
                  videoUrl: videosList[index].videoUrl,
                  videoId: videosList[index].id,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    videosList[index].username.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    videosList[index].caption.toString(),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.music_note,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(videosList[index].songName,
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(top: size.height / 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              buildProfile(videosList[index].profilePhoto ??
                                  'https://www.postmalone.com/files/2022/05/Rectangle-8-1.png'),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    child: Icon(
                                      Icons.favorite,
                                      size: 40,
                                      color: videosList[index].likes.contains(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          ? Colors.red
                                          : Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    videosList[index].likes.length.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () async{
                                      await getIt<NavigationService>()
                                          .showBottomSheet(
                                              CommentsDialog(id: videosList[index].id,), context);
                                    },
                                    child: Icon(
                                      Icons.comment,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    videosList[index].commentCount.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    child: Icon(
                                      Icons.share,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    videosList[index].shareCount.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 35,
                                  ),
                                  CircleAnimation(
                                      child: MusicAlbum(
                                          profilePhoto:
                                              'https://www.postmalone.com/files/2022/05/Rectangle-8-1.png')),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                )
              ],
            );
          }),
      loading: () {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
      error: (error, stackTrace) {
        print('ERROR: ${error.toString()}');
        print(stackTrace);
        //throw stackTrace;
        return const MyErrorWidget();
      },
    ));
  }
}
