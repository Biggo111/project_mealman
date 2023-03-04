import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/core/app_colors.dart';
import 'package:project_mealman/app/core/services/firebase_auth_methods.dart';
import 'package:project_mealman/app/screens/RestaurentEnd/restaurent_home_screen.dart';
import 'package:project_mealman/app/screens/global_home_screen.dart';

class LoginTab extends StatefulWidget {
  const LoginTab({super.key});

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  String? userType;
  Future<void> loginUser() async {
    await FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
      email: loginEmailController.text.trim(),
      password: loginPasswordController.text.trim(),
      context: context,
    );
    // User? user = FirebaseAuth.instance.currentUser;
    // if(user==null){
    //   return;
    // }
    //userType = await FirebaseFirestore.instance.collection("Authenticated_User_Info").doc(user.uid).get().then((value)=>value.data()!['userType']);
    //user = firebaseAuthMethods.userID;
  }

  void passwordReset() {
    FirebaseAuthMethods(FirebaseAuth.instance).forgotPassword(
      email: loginEmailController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          TextFormField(
            decoration: InputDecoration(
              enabled: true,
              suffixIcon: Icon(Icons.person),
              hintText: "Enter email",
              hintStyle: TextStyle(
                color: Colors.black38,
                fontFamily: 'Ubuntu',
                fontSize: 20.sp,
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            controller: loginEmailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            onChanged: (String value) {},
          ),
          SizedBox(
            height: 30.h,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              enabled: true,
              suffixIcon: Icon(Icons.lock),
              hintText: "Enter Password",
              hintStyle: TextStyle(
                color: Colors.black38,
                fontFamily: 'Ubuntu',
                fontSize: 20.sp,
              ),
            ),
            controller: loginPasswordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            onChanged: (String value) {},
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 155.w,
            ),
            child: TextButton(
              child: const Text(
                "Forgot password?",
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  color: Colors.black45,
                ),
              ),
              onPressed: (){
                if(loginEmailController.text.isEmpty){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Email Field Empty!'),
                        content:
                            const Text('Please Enter Your Email!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
                else{
                  passwordReset();
                }
              } 
            ),
          ),
           SizedBox(
            height: 50.h,
          ),
          SizedBox(
            height: 45.h,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (loginEmailController.text.isEmpty ||
                    loginPasswordController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Empty fields'),
                        content:
                            const Text('Please Enter Your Email and Password!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  await loginUser();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: Text(
                "Login",
                style: TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 20.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
