import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  String checkName = '';
  String checknumber = '';
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
          .then((UserCredential userCredential) {
        String userId = userCredential.user!.uid;
        String name = checkName;
        String phone = checknumber;

        Map<String, dynamic> userData = {
          "userId": userId,
          "email": email,
          "name": name,
          "phone": phone,
          "createdAt": DateTime.now()
        };

        FirebaseFirestore.instance
            .collection("Authenticated_User_Info")
            .doc(userId)
            .set(userData);
      });
      await sendEmailVarification(context);
    } on FirebaseAuthException catch (e) {
      Logger().i(e.message.toString());
    }
  }

  Future<void>forgotPassword({
    required String email,
  })async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void>loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  })async {
    try{
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(!_auth.currentUser!.emailVerified){
        await sendEmailVarification(context);
      }
    } on FirebaseAuthException catch (e){
      Logger().i(e.message);
    }
  }

  Future<void>sendEmailVarification(BuildContext context) async{
    try{
      _auth.currentUser!.sendEmailVerification();
      const AlertDialog();
    } on FirebaseAuthException catch (e){
      Logger().i(e.message.toString());
    }
  }
}
