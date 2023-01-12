import 'package:flutter/material.dart';
import 'package:project_mealman/app/core/app_colors.dart';

class SignupTab extends StatefulWidget {
  const SignupTab({super.key});

  @override
  State<SignupTab> createState() => _SignupTabState();
}

class _SignupTabState extends State<SignupTab> {
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
          onChanged: (String value) {},
        ),
        const SizedBox(height: 30,),
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
          onChanged: (String value) {},
        ),
        const SizedBox(height: 30,),
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
          onChanged: (String value) {},
        ),
        const SizedBox(height: 30,),
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
          onChanged: (String value) {},
        ),
        const SizedBox(height: 30,),
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
          onChanged: (String value) {},
        ),
        const SizedBox(height: 30,),
        SizedBox(
          height: 45,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: (){},
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