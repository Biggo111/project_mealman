import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
//import 'package:image_uploader/widgets/drawer.dart';

import '../MyDrawer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String myName = "";
  String myEmail = "";
  String myPhone = "";
  String myType = "";
  Future<Map<String, dynamic>?> fetchUserInfo() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      //Logger().i("Inside the try ${user!.uid}");
      if (user == null) {
        myName = "You are not logged in";
      } else {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection("Authenticated_User_Info")
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          // Logger().i(snapshot.data());
          setState(() {
            myName = data['name'];
            myEmail = data['email'];
            myPhone = data['phone'];
            myType = data['userType'];
          });

          return data;
        } else {
          myName = "No data found for the user";
        }
      }
    } catch (e) {
      //Logger().i(_resName);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          backgroundColor: HexColor("FE7C00"),
          //foregroundColor: Colors.white,

          title: Title(
            child: Text(
              "My Profile",
              style: TextStyle(color: Colors.white),
            ),
            color: HexColor("FE7C00"),
          ),
        ),
        body: Container(
          color: HexColor("EDDFDF"),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _getProfilePicCard(),
                _getUserNameCard(),
                _getUserEmailCard(),
                _getUserPasswordCard(),
                _getUserPhoneCard(),
                _getUserSocialMediaCard(),
                Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //_getSaveButton()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getProfilePicCard() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0.r),
        ),
        elevation: 20,
        child: Container(
          height: 200.w,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.all(0.0.sp),
                child: CircleAvatar(
                  radius: 70.r,
                  backgroundImage: AssetImage(
                      "assets/userend_images/profileLogo.png"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("              "),
                  Text(
                    myName,
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.camera_alt,
                        size: 35.sp,
                      ))
                ],
              )
            ],
          ),
        ));
  }

  Widget _getUserNameCard() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0.r),
        ),
        elevation: 20,
        child: Container(
          height: 90.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
          child: Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Username",
                  style: TextStyle(fontSize: 20.sp),
                ),

                Text(
                  myName,
                  style: TextStyle(fontSize: 15.sp),
                ), //fetch from database
              ],
            ),
          ),
        ));
  }

  Widget _getUserEmailCard() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0.r),
        ),
        elevation: 20,
        child: Container(
          height: 90.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
          child: Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Email",
                  style: TextStyle(fontSize: 20.sp),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      myEmail,
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    //    IconButton(
                    // onPressed:(){

                    // }, icon:Icon(Icons.edit,size: 25,))
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget _getUserPasswordCard() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0.r),
        ),
        elevation: 20,
        child: Container(
          height: 90.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
          child: Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "User Type",
                  style: TextStyle(fontSize: 20.sp),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      myType,
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    //    IconButton(
                    // onPressed:(){

                    // }, icon:Icon(Icons.edit,size: 25,))//fetch from database and make it hidden text
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget _getUserPhoneCard() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0.r),
        ),
        elevation: 20,
        child: Container(
          height: 90.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
          child: Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Phone Number",
                  style: TextStyle(fontSize: 20.sp),
                ),

                Text(
                  myPhone,
                  style: TextStyle(fontSize: 15.sp),
                ), //fetch from database
              ],
            ),
          ),
        ));
  }

  Widget _getUserSocialMediaCard() {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0.r),
        ),
        elevation: 20,
        child: Container(
          height: 90.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
          child: Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Connect Socials",
                  style: TextStyle(fontSize: 20.sp),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.facebook,
                      color: Colors.blue,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  // Widget _getSaveButton(){
  //   return ElevatedButton(
  //             style: ElevatedButton.styleFrom(
  //               padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
  //               primary: HexColor("FE7C00"),
  //               shape: StadiumBorder(),
  //             ),
  //             onPressed: (() {}),
  //             child: Text("Save",style: TextStyle(fontSize: 20),),
  //           );
  // }

}
