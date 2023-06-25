import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/firestore/firestore_list.dart';
import 'package:firebase_series/ui/Auth/login.dart';
import 'package:firebase_series/ui/posts/post_screen.dart';
import 'package:firebase_series/ui/upload_image.dart';
import 'package:flutter/material.dart';

class SplashServices {
  isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user!=null) {
      Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
    });
    }
    else{
      Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ));
    });
    }
    
  }
}
