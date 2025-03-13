import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants.dart';
import 'package:paisay_da_da/presentation/ui/auth/signup_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Paisay de de",
                style: GoogleFonts.aBeeZee(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              SizedBox(height: 10),
              Image.asset(
                Constants.logoImg,
                fit: BoxFit.cover,
              ),
              Text(
                "Dosti apni jagah, hisaab apni jagah",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Color(0xFF707070),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              AppElevatedButton(
                text: 'Lets Get Started >',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignupScreen();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
