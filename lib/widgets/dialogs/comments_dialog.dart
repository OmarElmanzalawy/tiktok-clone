import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone2/widgets/comment.dart';
import 'package:tiktok_clone2/widgets/trailing_textfield.dart';

class CommentsDialog extends StatelessWidget {
  CommentsDialog({super.key});

  final TextEditingController _commentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS || Theme.of(context).platform == TargetPlatform.macOS;
    final size = MediaQuery.sizeOf(context);
    return Container(
      height: size.height * 0.7,
      width: size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index){
                return Comment();
              }
              )
          ),
          Divider(),
          TrailingTextfield(
            controller: _commentsController,
            hintText: 'send a comment...',
            onTap: (){

            },
          ),
        ],
      ),
    );
  }
}