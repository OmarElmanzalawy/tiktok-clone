import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone2/constants/app_constants.dart';
import 'package:tiktok_clone2/models/comment_model.dart';
import 'package:tiktok_clone2/services/comment_service.dart';
import 'package:tiktok_clone2/services/navigation_service.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentWidget extends StatelessWidget {
   CommentWidget({super.key, required this.commentModel});

   final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                    backgroundImage: NetworkImage(commentModel.profilePhoto ?? AppConstants.defaultProfileImage ),
                    //backgroundImage: N,
                  ),
                title: Row(
                  children: [
                    Text(commentModel.username,style: const TextStyle(fontSize: 15, color: Colors.red,fontWeight: FontWeight.w500),),
                    SizedBox(width: 8,),
                    Text(commentModel.comment,style: const TextStyle(fontSize: 15, color: Colors.white,fontWeight: FontWeight.w500),)
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text( tago.format(commentModel.datePublished.toDate()) ,style: TextStyle(fontSize: 12,color: Colors.white),),
                    const SizedBox(width: 10,),
                    Text('${commentModel.likes.length.toString()} likes',style: TextStyle(
                      fontSize: 12,
                      color: Colors.white
                    ),),
                    
                  ],
                ),
                trailing: IconButton(onPressed: ()async{
                  await CommentService.likeComment(commentModel.id);
                }, 
                icon: commentModel.likes.contains(FirebaseAuth.instance.currentUser!.uid) ?  
                Icon(Icons.favorite, color: Colors.red,) 
                : Icon(Icons.favorite_outline,color: Colors.white,size: 25,),
                ),
                );;
  }
}