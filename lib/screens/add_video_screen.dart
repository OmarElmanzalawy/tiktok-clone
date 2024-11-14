import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone2/constants/app_constants.dart';
import 'package:tiktok_clone2/services/navigation_service.dart';
import 'package:tiktok_clone2/widgets/dialogs/add_video_dialog.dart';

class AddVideoScreen extends ConsumerWidget {
  const AddVideoScreen({super.key});

  showOptionsDialog(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => AddVideoDialog(),
    );
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            showOptionsDialog(context);
          },
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(color: AppConstants.buttonColor),
            child: const Center(
              child: Text(
                'Add Video',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
