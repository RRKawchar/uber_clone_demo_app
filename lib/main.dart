import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone_demo/src/core/theme/app_theme.dart';
import 'package:uber_clone_demo/src/features/auth/view/screens/forget_password_screen.dart';
import 'package:uber_clone_demo/src/features/auth/view/screens/registers_screen.dart';
import 'package:uber_clone_demo/src/features/splash/view/screen/splash_screen.dart';
import 'firebase_options.dart';


late Size mqSize;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uber Clone Demo App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
       darkTheme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
