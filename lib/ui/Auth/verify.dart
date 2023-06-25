import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utilities/utils.dart';
import '../widgets/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {
 final String verificationId;
  const VerifyCodeScreen({super.key,required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
   final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Verify")),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            TextFormField(
              controller: phoneNumberController,
              decoration: const InputDecoration(hintText: "6- digit code"),
            ),
            const SizedBox(
              height: 80,
            ),
            RoundButton(
                title: "Verify",
                loading: loading,
                onTap: () {
                  
                })
          ],
        ),
      ),
    );
  }
}
