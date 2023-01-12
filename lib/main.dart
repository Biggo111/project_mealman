import 'package:flutter/material.dart';
import 'package:project_mealman/app/core/services/firebase_service.dart';
import 'package:project_mealman/app/screens/Signup_Page/signup_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.enableFirebase();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignupPage(),
    );
  }
}