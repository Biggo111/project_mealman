import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/app/core/app_colors.dart';
import 'package:project_mealman/app/core/services/firebase_auth_methods.dart';
import 'package:project_mealman/app/screens/Signup_Page/login_tab.dart';

class SignupTab extends StatefulWidget {
  const SignupTab({super.key});

  @override
  State<SignupTab> createState() => _SignupTabState();
}

class _SignupTabState extends State<SignupTab> {
  final signupNameController = TextEditingController();
  final signupEmailController = TextEditingController();
  final signupPasswordController = TextEditingController();
  final signupConfirmpasswordController = TextEditingController();
  final signupPhonenumberController = TextEditingController();

  void signupUser() async {
    if (signupPasswordController.text.toString() ==
        signupConfirmpasswordController.text.toString()) {
      FirebaseAuthMethods(FirebaseAuth.instance).signupWithEmail(
          email: signupEmailController.text.trim(),
          password: signupPasswordController.text.trim(),
          name: signupNameController.text.trim(),
          number: signupPhonenumberController.text.trim(),
          context: context);
    } else {
      //Logger().i("Confirm password is not matching");
      showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Error!'),
                    content: const Text('Confirm Password is not matching to the password!'),
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
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        TextField(
          decoration: const InputDecoration(
            enabled: true,
            suffixIcon: Icon(Icons.person),
            hintText: "Enter Username",
            hintStyle: TextStyle(
              color: Colors.black38,
              fontFamily: 'Ubuntu',
              fontSize: 20,
            ),
          ),
          controller: signupNameController,
          onChanged: (String value) {},
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
          decoration: const InputDecoration(
            enabled: true,
            suffixIcon: Icon(Icons.email),
            hintText: "Enter your email",
            hintStyle: TextStyle(
              color: Colors.black38,
              fontFamily: 'Ubuntu',
              fontSize: 20,
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          controller: signupEmailController,
          onChanged: (String value) {},
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
          decoration: const InputDecoration(
            enabled: true,
            suffixIcon: Icon(Icons.lock),
            hintText: "Enter password",
            hintStyle: TextStyle(
              color: Colors.black38,
              fontFamily: 'Ubuntu',
              fontSize: 20,
            ),
          ),
          controller: signupPasswordController,
          onChanged: (String value) {},
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
          decoration: const InputDecoration(
            enabled: true,
            suffixIcon: Icon(Icons.lock),
            hintText: "Confirm password",
            hintStyle: TextStyle(
              color: Colors.black38,
              fontFamily: 'Ubuntu',
              fontSize: 20,
            ),
          ),
          controller: signupConfirmpasswordController,
          onChanged: (String value) {},
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
          decoration: const InputDecoration(
            enabled: true,
            suffixIcon: Icon(Icons.call),
            hintText: "Enter your phone number",
            hintStyle: TextStyle(
              color: Colors.black38,
              fontFamily: 'Ubuntu',
              fontSize: 20,
            ),
          ),
          keyboardType: TextInputType.number,
          controller: signupPhonenumberController,
          onChanged: (String value) {},
        ),
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          height: 45,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if(signupNameController.text.isEmpty || signupEmailController.text.isEmpty || signupPasswordController.text.isEmpty || signupConfirmpasswordController.text.isEmpty || signupPhonenumberController.text.isEmpty){
                showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Alert!!'),
                    content: const Text('Fill up all the fields'),
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
                signupUser();
              }
              
              //Get.to(()=>const LoginTab());
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const LoginTab()),
              // );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: const Text(
              "Signup",
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
