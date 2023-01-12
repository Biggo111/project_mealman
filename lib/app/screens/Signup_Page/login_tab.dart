import 'package:flutter/material.dart';
import 'package:project_mealman/app/core/app_colors.dart';

class LoginTab extends StatefulWidget {
  const LoginTab({super.key});

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
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
            keyboardType: TextInputType.emailAddress,
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
              onPressed: (){},
            ),
          ),
          const SizedBox(
            height: 50,
          ),
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
