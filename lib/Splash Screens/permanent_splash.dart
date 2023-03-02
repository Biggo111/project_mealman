import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_mealman/app/core/app_colors.dart';
import 'package:project_mealman/app/screens/Signup_Page/signup_page.dart';

class PermanentSplash extends StatefulWidget {
  const PermanentSplash({super.key});

  @override
  State<PermanentSplash> createState() => _PermanentSplashState();
}

class _PermanentSplashState extends State<PermanentSplash> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value){
      Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (ctx)=> const SignupPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/userend_images/FirstPage.png"),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 650,
              ),
              SpinKitFadingCircle(
                color: AppColors.mainColor,
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
