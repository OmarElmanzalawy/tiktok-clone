import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone2/providers/comments_stream_provider.dart';
import 'package:tiktok_clone2/services/comment_service.dart';
import 'package:tiktok_clone2/widgets/comment_widget.dart';
import 'package:tiktok_clone2/widgets/error_widget.dart';
import 'package:tiktok_clone2/widgets/trailing_textfield.dart';

class CommentsDialog extends ConsumerStatefulWidget {
  final String id;
  CommentsDialog({super.key, required this.id});

  @override
  ConsumerState<CommentsDialog> createState() => _CommentsDialogState();
}

class _CommentsDialogState extends ConsumerState<CommentsDialog> {
  final TextEditingController _commentsController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _commentsController.dispose();
    print('disposed');
  }

  @override
  Widget build(BuildContext context) {
    
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS || Theme.of(context).platform == TargetPlatform.macOS;
    final size = MediaQuery.sizeOf(context);
    CommentService.updatePostId(widget.id);
    print('Post ID: ${CommentService.getPostId}');
    final comments = ref.watch(commentsStreamProvider);
    
    return Container(
      height: size.height * 0.7,
      width: size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: comments.when(
              data:  (commentList) {
                print('COMMENTS: ${commentList}');
              return commentList.isEmpty ?  Center(child: Text('No Comments')) 
              :
              ListView.builder(
              itemCount: commentList.length,
              itemBuilder: (context, index){
                
               
                return CommentWidget(commentModel: commentList[index],);
              }
              );
              }, 
              loading: () {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
            error: (error, stackTrace) {
        print('ERROR: ${error.toString()}');
        print(stackTrace);
        //throw stackTrace;
        return const Center(child: Text('An error occured while loading'),);
      },
             
             ),

          ),
          Divider(),
          TrailingTextfield(
            controller: _commentsController,
            hintText: 'send a comment...',
            onTap: ()async{
              await CommentService.postComment(_commentsController.text);
            },
          ),
        ],
      ),
    );
  }
}