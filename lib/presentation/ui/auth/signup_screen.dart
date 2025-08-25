import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants/constants.dart';
import 'package:paisay_da_da/core/socket.io.dart';
import 'package:paisay_da_da/presentation/notifier/auth.notifier.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/dashboard_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';
import 'package:paisay_da_da/presentation/widgets/app_outline_button.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<AuthNotifier>(context, listen: false);
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
              icon: Icon(
                Icons.apple,
                color: Colors.white,
                // size: 25,
              ),
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
              onPressed: () async {
                bool response = await authNotifier.googleAuth(context);

                if (response) {}
              },
              icon: Image.asset(
                Constants.google,
                height: 20,
              ),
            ),
            const SizedBox(height: 20),
            AppOutlineButton(
              text: "Continue with Email",
              onPressed: () {
                SocketService().sendMessage("email clicked");
              },
              icon: Icon(
                Icons.email_outlined,
                color: Colors.black,
                size: 25,
              ),
            ),
            const SizedBox(height: 25),
            Text.rich(
              TextSpan(
                text: "By continuing, you agree to our ",
                style: GoogleFonts.aBeeZee(
                  fontSize: 16,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: "Terms of Service",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("Terms of Service clicked");
                      },
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        print("Privacy Policy clicked");
                      },
                  ),
                  const TextSpan(text: "."),
                ],
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            )
          ],
        ),
      ),
    );
  }
}
