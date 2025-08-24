import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants/constants.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/dashboard_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';
import 'package:paisay_da_da/presentation/widgets/app_outline_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Constants.splitImg,
              height: 200,
            ),
            const SizedBox(height: 20),
            AppElevatedButton(
              text: 'Continue with Apple',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            AppOutlineButton(
              text: "Continue with Google",
              onPressed: () {},
              icon: Icon(
                Icons.golf_course_outlined,
                color: Colors.black,
                size: 20,
              ),
            ),
            const SizedBox(height: 20),
            AppOutlineButton(
              text: "Continue with Email",
              onPressed: () {},
              icon: Icon(
                Icons.email_outlined,
                color: Colors.black,
                size: 20,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "By continuing, you agree to our Terms of Service and Privacy Policy.",
              style: GoogleFonts.aBeeZee(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
