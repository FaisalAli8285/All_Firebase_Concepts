import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/ui/Auth/login_with_number.dart';
import 'package:firebase_series/ui/Auth/signup.dart';
import 'package:firebase_series/ui/forgot_screen.dart';
import 'package:firebase_series/ui/posts/post_screen.dart';
import 'package:firebase_series/ui/widgets/round_button.dart';
import 'package:firebase_series/utilities/utils.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final PasswordController = TextEditingController();
  bool loading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    PasswordController.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final __formKey = GlobalKey<FormState>();
  void logIN() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text, password: PasswordController.text)
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PostScreen(),
          ));
          setState(() {
            loading = false;
          });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
      setState(() {
            loading = false;
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(child: Text("Login")),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
                key: __formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: PasswordController,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.password_outlined)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            const SizedBox(
              height: 50,
            ),
            RoundButton(
                title: "Login",
                loading: loading,
                onTap: () {
                  if (__formKey.currentState!.validate()) {
                    logIN();
                  }
                }),
                 Align(
                  alignment: Alignment.bottomRight,
                   child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ForgotScreen();
                          },
                        ));
                      },
                      child: const Text("Forgot Password")),
                 ),
            const SizedBox(
              height: 30,
            ),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const SignUpScreen();
                        },
                      ));
                    },
                    child: const Text("Sing Up")),
              ],
            ),
            const SizedBox(height: 30,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LOginWithNumber(),));
              },
              child: Container(
                height: 50,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.black,
                  ),
                ),
                child: const Center(child: Text("Enter your phone number")),
              ),
            )
          ],
        ),
      ),
    );
  }
}
