import 'package:flutter/material.dart';
import 'package:tiktok_clone2/widgets/circle_animation.dart';
import 'package:tiktok_clone2/widgets/music_album.dart';
import 'package:tiktok_clone2/widgets/video_player_item.dart';

class VideoScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 2,
            controller: pageController,
            itemBuilder: (index, context) {
              return Stack(
                children: [
                  VideoPlayerItem(),
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
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'username',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'caption',
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
                                        Text('Song Name',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold))
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
                                buildProfile('https://www.postmalone.com/files/2022/05/Rectangle-8-1.png'),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      child: Icon(
                                        Icons.favorite,size: 40,color: Colors.red,
                                        ),
                                        ),
                                        const SizedBox(height: 7,),
                                        Text('2,200',style: TextStyle(fontSize: 20,color: Colors.white),),
                                        SizedBox(height: 10,),

                                                                           InkWell(
                                      child: Icon(
                                        Icons.comment,size: 40,color: Colors.white,
                                        ),
                                        ),
                                        const SizedBox(height: 7,),
                                        Text('7',style: TextStyle(fontSize: 20,color: Colors.white),),
                                        SizedBox(height: 10,),

                                                                           InkWell(
                                      child: Icon(
                                        Icons.share,size: 40,color: Colors.white,
                                        ),
                                        ),
                                        const SizedBox(height: 7,),
                                        Text('2',style: TextStyle(fontSize: 20,color: Colors.white),),
                                        SizedBox(height: 35,),
                                        CircleAnimation(child: MusicAlbum(profilePhoto:  'https://www.postmalone.com/files/2022/05/Rectangle-8-1.png')),
                                    
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
            }));
  }
}
