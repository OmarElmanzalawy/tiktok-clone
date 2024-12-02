import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone2/models/comment_model.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentWidget extends StatelessWidget {
   CommentWidget({super.key, required this.commentModel});

   final CommentModel commentModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
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
                trailing: IconButton(onPressed: (){}, 
                icon: Icon(Icons.favorite_outline,color: Colors.red,size: 25,)
                ),
                );;
  }
}