import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_mealman/app/core/app_colors.dart';
import 'package:project_mealman/app/core/services/firebase_auth_methods.dart';
import 'package:project_mealman/app/screens/global_home_screen.dart';

class LoginTab extends StatefulWidget {
  const LoginTab({super.key});

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  void loginUser(){
    FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
      email: loginEmailController.text,
      password: loginPasswordController.text,
      context: context,
    );
  }
  void passwordReset(){
    FirebaseAuthMethods(FirebaseAuth.instance).forgotPassword(
      email: loginEmailController.text,
    );
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          TextField(
            decoration: const InputDecoration(
              enabled: true,
              suffixIcon: Icon(Icons.person),
              hintText: "Enter email",
              hintStyle: TextStyle(
                color: Colors.black38,
                fontFamily: 'Ubuntu',
                fontSize: 20,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            controller: loginEmailController,
            onChanged: (String value) {},
          ),
          const SizedBox(height: 30,),
          TextField(
            obscureText: true,
            decoration: const InputDecoration(
              enabled: true,
              suffixIcon: Icon(Icons.lock),
              hintText: "Enter Password",
              hintStyle: TextStyle(
                color: Colors.black38,
                fontFamily: 'Ubuntu',
                fontSize: 20,
              ),
            ),
            controller: loginPasswordController,
            onChanged: (String value) {},
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 155,
            ),
            child: TextButton(
              child: const Text(
                "Forgot password?",
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.black45,
                ),
              ),
              onPressed: ()=>passwordReset(),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: 45,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){
                loginUser();
                Get.to(GlobalHomeScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
