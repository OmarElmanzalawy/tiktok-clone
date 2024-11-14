import 'package:flutter/material.dart';
import 'package:tiktok_clone2/constants/app_constants.dart';
import 'package:tiktok_clone2/services/auth_service.dart';
import 'package:tiktok_clone2/widgets/my_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
              color: AppConstants.buttonColor,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //const SizedBox(height: 25,),
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
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Don\'t have an account?',
                ),
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/signup'),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: Text(
                      'Register',
                      style: TextStyle(color: AppConstants.buttonColor),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            width: size.width - 40,
            height: 50,
            decoration: BoxDecoration(
                color: AppConstants.buttonColor, borderRadius: BorderRadius.circular(5)),
            child: InkWell(
                onTap: () {
                  AuthService.loginUser(email: _emailController.text, password: _passwordController.text, context: context);
                },
                child: const Center(
                    child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ))),
          )
        ]),
      ),
    );
  }
}
