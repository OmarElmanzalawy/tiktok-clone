import 'package:flutter/material.dart';
import 'package:tiktok_clone2/constants/app_constants.dart';
import 'package:tiktok_clone2/widgets/my_textfield.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Tiktok Clone',
            style: TextStyle(
              fontSize: 35,
              color: buttonColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Text(
            'Register',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/default-profile-picture-avatar-photo-placeholder-vector-illustration-default-profile-picture-avatar-photo-placeholder-vector-189495158.jpg'),
              ),
              Positioned(
                //top: 150,
                bottom: 0,
                left: 140,
                child: Container(
                  child: IconButton(
                    icon: Icon(Icons.add_a_photo,color: Colors.white,),
                    onPressed: (){

                    }, 
                    ),
                  decoration: BoxDecoration(
                    color:  Colors.redAccent.shade100, //Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 10,),
                    Container(
            width: size.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: MyTextField(
              controller: _userNameController,
              labelText: 'Username',
              icon: Icons.email,
            ),
          ),
          const SizedBox(height: 25,),
          Container(
            width: size.width,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: MyTextField(
              controller: _emailController,
              labelText: 'Email',
              icon: Icons.email,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            width: size.width,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: MyTextField(
              controller: _passwordController,
              labelText: 'Password',
              icon: Icons.lock,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 25),
            width: size.width - 40,
            height: 50,
            decoration: BoxDecoration(
                color: buttonColor, borderRadius: BorderRadius.circular(5)),
            child: InkWell(
                onTap: () {
                  print('Clicked');
                },
                child: const Center(
                    child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ))),
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account? ',
                ),
                InkWell(
                  onTap: () => print('navigating user'),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Text(
                      'Register',
                      style: TextStyle(color: buttonColor),
                    ),
                  ),
                )
              ],
            ),
        ]),
      ),
    );
  }
}