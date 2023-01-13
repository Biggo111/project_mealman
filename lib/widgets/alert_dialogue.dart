import 'package:flutter/material.dart';
import 'package:project_mealman/app/core/app_colors.dart';

class AlertDialogue extends StatefulWidget {
  const AlertDialogue({super.key, required String text});

  @override
  State<AlertDialogue> createState() => _AlertDialogueState();
}

class _AlertDialogueState extends State<AlertDialogue> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: const Text("Message!!!"),
        content: const Text("Varification mail sent"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Container(
              color: AppColors.mainColor,
              padding: const EdgeInsets.all(14),
              child: const Text("OK"),
            ),
          ),
        ],
      ),
    );
  }
}
