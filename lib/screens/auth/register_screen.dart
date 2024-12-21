import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone2/constants/app_constants.dart';
import 'package:tiktok_clone2/providers/profile_image_provider.dart';
import 'package:tiktok_clone2/services/auth_service.dart';
import 'package:tiktok_clone2/widgets/my_textfield.dart';

class SignupScreen extends ConsumerWidget {
  SignupScreen({super.key});
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final profilePhoto = ref.watch(profilePictureProvider); 
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          height: size.height,
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Tiktok Clone',
              style: TextStyle(
                fontSize: 35,
                color: AppConstants.buttonColor,
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
                  backgroundImage:  profilePhoto !=null ? FileImage(profilePhoto!) : NetworkImage('https://thumbs.dreamstime.com/b/default-profile-picture-avatar-photo-placeholder-vector-illustration-default-profile-picture-avatar-photo-placeholder-vector-189495158.jpg'),
                ),
                Positioned(
                  //top: 150,
                  bottom: 0,
                  left: 140,
                  child: Container(
                    child: IconButton(
                      icon: Icon(Icons.add_a_photo,color: Colors.white,),
                      onPressed: (){
                        ref.read(profilePictureProvider.notifier).pickImage();
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
                isObscure: true,
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
                  color: AppConstants.buttonColor, borderRadius: BorderRadius.circular(5)),
              child: InkWell(
                  onTap: () async{
                    print('register');
                    await AuthService.registerUser(
                      email: _emailController.text,
                      password: _passwordController.text,
                      username: _userNameController.text,
                      image: profilePhoto,
                    );
                    profilePhoto != null ? print(profilePhoto.exists()) : null;
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  child: const Center(
                      child: Text(
                    'Register',
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
                    'Already Have an account?  ',
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Text(
                        'Login',
                        style: TextStyle(color: AppConstants.buttonColor),
                      ),
                    ),
                  )
                ],
              ),
          ]),
        ),
      ),
    );
  }
}