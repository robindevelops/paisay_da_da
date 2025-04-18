import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants.dart';
import 'dart:async';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/dashboard_screen.dart';
import 'package:paisay_da_da/presentation/ui/welcome/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        _checkLoginStatus();
      },
    );
  }

  void _checkLoginStatus() async {
    bool? isLoggedIn = await HiveDatabase.getlogin();
    if (isLoggedIn == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen(),
        ), // Replace with your Signup screen
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // or your app theme
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App icon

            const SizedBox(height: 20),

            // App name
            SizedBox(
              height: 300,
              child: Image.asset(
                Constants.logoImg,
                fit: BoxFit.cover,
              ),
            ),
            // Text(
            //   "Split It",
            //   style: GoogleFonts.aBeeZee(
            //     fontSize: 28,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black,
            //     letterSpacing: 1.2,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
