import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:project_mealman/main.dart';

import '../../screens/RestaurentEnd/restaurent_home_screen.dart';
import '../../screens/global_home_screen.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  String? userID;
  String checkName = '';
  String checknumber = '';
  String? userType;
  FirebaseAuthMethods(this._auth);

  Future<void> signupWithEmail({
    required String email,
    required String password,
    required String name,
    required String number,
    required BuildContext context,
  }) async {
    try {
      checkName = name;
      checknumber = number;
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((UserCredential userCredential) async {
        //await userCredential.user!.sendEmailVerification();
        //waiting for the user to be verified
        //await userCredential.user!.reload();

        String userId = userCredential.user!.uid;
        String name = checkName;
        String phone = checknumber;
        userID = userId;
        //Logger().i("My user ID is : $userID");

        if (email.startsWith("cse_") && email.endsWith("@lus.ac.bd")) {
          userType = "student";
        } else if (email.endsWith("@lus.ac.bd")) {
          userType = "teacher";
        } else {
          userType = "restaurant_required";
        }

        Map<String, dynamic> userData = {
          "userId": userId,
          "email": email,
          "name": name,
          "phone": phone,
          "userType": userType,
          "createdAt": DateTime.now()
        };

        FirebaseFirestore.instance
            .collection("Authenticated_User_Info")
            .doc(userId)
            .set(userData);
        // if (userCredential.user!.emailVerified) {
        // } else {
        //   showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: const Text('Verify your email!'),
        //         content:
        //             const Text('Check your email and verify it to sign up!'),
        //         actions: [
        //           TextButton(
        //             onPressed: () {
        //               Navigator.of(context).pop();
        //             },
        //             child: const Text('OK'),
        //           ),
        //         ],
        //       );
        //     },
        //   );
        // }
      });
      await sendEmailVerification(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Signup Successful BUT...'),
            content: const Text(
                'An email is sent to you, you have to verify this and then go to the loginPage and login...'),
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
    } on FirebaseAuthException catch (e) {
      //Logger().i(e.message.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error!'),
            content: Text("${e.message.toString()}"),
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

  Future<void> forgotPassword({
    required String email,
  }) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        if (!user.emailVerified) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Please Verify!'),
                content: const Text(
                    'Please verify with your email. We sent you an email while signing up'),
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
          return;
        }
        userType = await FirebaseFirestore.instance
            .collection("Authenticated_User_Info")
            .doc(user.uid)
            .get()
            .then((value) => value.data()!['userType']);
        if (userType != null) {
          if (userType == 'student' || userType == 'teacher') {
            Get.to(() => const GlobalHomeScreen());
          } else if (userType == 'restaurant') {
            Get.to(() => const RestaurentHomeScreen());
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Verification Required!'),
                  content: const Text(
                      'If you are a restaurant owner you will be verified!'),
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
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('You do\'t have any account'),
              content: const Text('Please Sign Up'),
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
      // if (!_auth.currentUser!.emailVerified) {
      //   await sendEmailVerification(context);
      // }
    } on FirebaseAuthException catch (e) {
      //Logger().i("The problem is ${e.message}");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Wrong Email and Password'),
            content: const Text('Please Enter correct Email and Password!'),
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

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      const AlertDialog();
    } on FirebaseAuthException catch (e) {
      Logger().i(e.message.toString());
    }
  }
}
