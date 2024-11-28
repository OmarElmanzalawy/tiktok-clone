import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  const Comment({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red,
                    //backgroundImage: N,
                  ),
                title: Row(
                  children: [
                    Text('username',style: const TextStyle(fontSize: 20, color: Colors.red,fontWeight: FontWeight.w700),),
                    Text('comment descrition',style: const TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.w500),)
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text('date',style: TextStyle(fontSize: 12,color: Colors.white),),
                    const SizedBox(width: 10,),
                    Text('10 likes',style: TextStyle(
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