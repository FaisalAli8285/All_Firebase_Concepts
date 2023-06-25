import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/ui/widgets/round_button.dart';
import 'package:firebase_series/utilities/utils.dart';
import 'package:flutter/material.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  final forgetPassword = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter Email",
                ),
                controller: forgetPassword,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            RoundButton(
                title: "Forgot",
                onTap: () {
                  auth.sendPasswordResetEmail(email: forgetPassword.text.toString()).then((value) {
                    Utils().toastMessage(
                        "We have sent you email to recover password,please check your email");
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                })
          ],
        ),
      ),
    );
  }
}
