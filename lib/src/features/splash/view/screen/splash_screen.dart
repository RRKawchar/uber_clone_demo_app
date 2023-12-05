import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uber_clone_demo/src/core/assistants/assistants_methods.dart';
import 'package:uber_clone_demo/src/core/globle/global.dart';
import 'package:uber_clone_demo/src/features/auth/view/screens/login_screen.dart';
import 'package:uber_clone_demo/src/features/main/view/screen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      if (firebaseAuth.currentUser != null) {
        firebaseAuth.currentUser != null
            ? AssistantsMethods.readCurrentUserOnlineInfo()
            : null;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    });
  }

  @override
  void initState() {
   startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Uber Clone Demo",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
