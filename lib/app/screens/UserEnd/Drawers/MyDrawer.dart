import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project_mealman/app/screens/Signup_Page/signup_page.dart';
import 'package:project_mealman/app/screens/UserEnd/Drawers/Drawer_Elements/profile.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: HexColor("FE7C00"),
      child: ListView(
        children: [
          DrawerHeader(
              padding: EdgeInsets.zero,
              child: Container(
                decoration: BoxDecoration(
                  
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("assets/userend_images/logo.png"),
                      fit: BoxFit.scaleDown), //
                ),
              )),
          ListTile(
            leading: Icon(
              CupertinoIcons.profile_circled,
              color: Colors.white,
              size: 40.sp,
            ),

            // title: Text("My Profile",style: TextStyle(fontSize: 25,color: Colors.white),),
            title: TextButton(
              
              
              onPressed: () {
                Get.to(()=> const Profile());
              },
              child: 
              
              Text(
                "My Profile",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
                ),

             
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.food_bank,
              color: Colors.white,
              size: 40.sp,
            ),
            title: TextButton(
              onPressed: () {},
              child: Text(
                "Become a seller",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
                ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.mail,
              color: Colors.white,
              size: 40.sp,
            ),
            title: TextButton(
              onPressed: () {},
              child: Text(
                "Invite a friend",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
                ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.contact_page,
              color: Colors.white,
              size: 40.sp,
            ),
            title: TextButton(
              onPressed: () {},
              child: Text(
                "Contact Us",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
                ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.white,
              size: 40.sp,
            ),
            title: TextButton(
              onPressed: () {},
              child: Text(
                "Settings",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
                ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.white,
              size: 40.sp,
            ),
            title: TextButton(
              onPressed: () async{
                await FirebaseAuth.instance.signOut();
                Get.to(()=>const SignupPage());
              },
              child: Text(
                "Logout",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                alignment: Alignment.centerLeft,
                ),
            ),
          )
        ],
      ),
    );
  }
}