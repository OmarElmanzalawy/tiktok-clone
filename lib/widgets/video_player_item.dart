import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone2/services/video_service.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final String videoId;
  const VideoPlayerItem({super.key, required this.videoUrl, required this.videoId});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late CachedVideoPlayerPlusController videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController = CachedVideoPlayerPlusController.networkUrl(Uri.parse(widget.videoUrl))..initialize().then((value) {
        videoPlayerController.play();
      videoPlayerController.setVolume(1);
      videoPlayerController.setLooping(true);      
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onDoubleTap: () async{
        print('Double tap');
        await VideoService.likeVideo(widget.videoId);
      },
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(color: Colors.black),
        child: CachedVideoPlayerPlus(videoPlayerController),
      ),
    );
  }
}