import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone2/constants/app_constants.dart';
import 'package:tiktok_clone2/providers/videos_stream_provider.dart';

class MyErrorWidget extends ConsumerWidget {
  const MyErrorWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width,
      height: size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 250,
            child: Image(image: AssetImage('assets/error.png'),fit: BoxFit.cover,),
            ),
            Text('An Error Occured',style: TextStyle(fontSize: 30,color: Colors.white),),
            SizedBox(height: 25,),
            Container(
            margin: const EdgeInsets.only(bottom: 50),
            width: 250,
            height: 50,
            decoration: BoxDecoration(
                
                color: AppConstants.buttonColor, borderRadius: BorderRadius.circular(25)),
            child: InkWell(
                onTap: () async{
                  ref.read(retryAttemptProvider.notifier).state+=1;
                },
                child: const Center(
                    child: Text(
                  'Retry',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ))),
                      )
        ],
      ),
    );
    
  }
}
