import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone2/constants/app_constants.dart';
import 'package:tiktok_clone2/providers/video_picker_provider.dart';
import 'package:tiktok_clone2/services/init_getit.dart';
import 'package:tiktok_clone2/services/navigation_service.dart';
import 'package:tiktok_clone2/services/upload_video_service.dart';
import 'package:tiktok_clone2/widgets/my_textfield.dart';
import 'package:video_player/video_player.dart';

class ConfirmVideoScreen extends ConsumerStatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmVideoScreen(this.videoFile, this.videoPath, {super.key});

  @override
  ConsumerState<ConfirmVideoScreen> createState() => _ConfirmVideoScreenState();
}

class _ConfirmVideoScreenState extends ConsumerState<ConfirmVideoScreen> {
  TextEditingController songController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  late VideoPlayerController videoController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoController = VideoPlayerController.file(widget.videoFile);
    videoController.initialize();
    videoController.play();
    videoController.setVolume(1);
    videoController.setLooping(true);
  }

  @override
  void dispose() {
    videoController.dispose();
    songController.dispose();
    captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent,),
      body: Column(
        children: [
          Expanded(child: VideoPlayer(videoController)),
          SizedBox(height: 30,),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
            Container(
            width: size.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: MyTextField(
              controller: songController,
              labelText: 'Song',
              icon: Icons.music_note,
            ),
          ),
          SizedBox(height: 10,),
                      Container(
            width: size.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: MyTextField(
              controller: captionController,
              labelText: 'Caption',
              icon: Icons.closed_caption,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: ElevatedButton(onPressed: ()async{
              await UploadVideoService.uploadvideo(songController.text, captionController.text, widget.videoPath);
              //getIt<NavigationService>().showSnackbar(text: 'Video Uploaded Successfully', context: context) : getIt<NavigationService>().showSnackbar(text: 'Error Occured', context: context);
              Navigator.pop(context);

            }, 
            style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppConstants.buttonColor) ),
            child: Text('Share!',style: TextStyle(fontSize: 20,color: Colors.white),)),
          )
              ],
            ),
          )
        ],
      )
    );
  }
}