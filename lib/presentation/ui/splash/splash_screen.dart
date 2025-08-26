import 'package:flutter/material.dart';
import 'package:paisay_da_da/core/constants/constants.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'dart:async';
import 'package:paisay_da_da/presentation/ui/auth/auth_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/dashboard_screen.dart';

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
    bool? isLoggedIn = await HiveDatabase.getValue("islogin");
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
          builder: (context) => AuthScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 500,
              child: Image.asset(
                Constants.splashImg,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
