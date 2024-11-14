import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone2/providers/video_picker_provider.dart';

class AddVideoDialog extends ConsumerWidget {
  const AddVideoDialog({super.key});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Container(
          height: MediaQuery.sizeOf(context).height * 0.25,
          width: double.infinity,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  ref.read(videoPickerProvider.notifier).pickVideo(ImageSource.gallery,context);
                  print('gallery');
                },
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: const Row(
                    children: const [
                      Icon(Icons.image),
                      Text(
                        ' Gallery',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  ref.read(videoPickerProvider.notifier).pickVideo(ImageSource.camera, context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0,right: 30,bottom: 30),
                  child: const Row(
                    children: const [
                      Icon(Icons.camera_alt),
                      Text(
                        ' Camera ',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            
          ),
        );
  }
}