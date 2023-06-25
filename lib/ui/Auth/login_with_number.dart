import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/ui/Auth/verify.dart';
import 'package:firebase_series/ui/widgets/round_button.dart';
import 'package:firebase_series/utilities/utils.dart';
import 'package:flutter/material.dart';

class LOginWithNumber extends StatefulWidget {
  const LOginWithNumber({super.key});

  @override
  State<LOginWithNumber> createState() => _LOginWithNumberState();
}

class _LOginWithNumberState extends State<LOginWithNumber> {
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Login")),
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
              decoration: const InputDecoration(hintText: "+1 9234568098"),
            ),
            const SizedBox(
              height: 80,
            ),
            RoundButton(
                title: "Login",
                onTap: () {
                  auth.verifyPhoneNumber(
                      verificationCompleted: (_) {},
                      verificationFailed: (e) {
                        Utils().toastMessage(e.toString());
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VerifyCodeScreen(
                                verificationId: verificationId,
                              ),
                            ));
                      },
                      codeAutoRetrievalTimeout: (e) {
                        Utils().toastMessage(e.toString());
                      });
                })
          ],
        ),
      ),
    );
  }
}
