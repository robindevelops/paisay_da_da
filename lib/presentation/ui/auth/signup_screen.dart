import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/dashboard_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';
import 'package:paisay_da_da/presentation/widgets/app_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Signup", style: GoogleFonts.aBeeZee(fontSize: 30)),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hintText: "First Name",
                          icon: Icons.person,
                          controller: firstName,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: CustomTextField(
                          hintText: "Last Name",
                          icon: Icons.person,
                          controller: lastName,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15), // Space between fields
                  CustomTextField(
                    hintText: "Email",
                    icon: Icons.email,
                    controller: emailController,
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    hintText: "Password",
                    icon: Icons.lock,
                    isPassword: true,
                    controller: passwordController, // Hide password
                  ),
                  SizedBox(height: 25),
                  AppElevatedButton(
                    text: "Register",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DashboardScreen();
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Signin",
                          style: GoogleFonts.aBeeZee(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // RichText(
                  //   textAlign: TextAlign.center,
                  //   text: TextSpan(
                  //     text: 'Joining our app means you agree with our ',
                  //     style: TextStyle(
                  //       color: Colors.grey[700],
                  //       fontSize: 13,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //     children: [
                  //       TextSpan(
                  //         text: 'Terms of Use',
                  //         style: TextStyle(
                  //           decoration: TextDecoration.underline,
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //         recognizer: TapGestureRecognizer()
                  //           ..onTap = _onTermsOfUseTapped,
                  //       ),
                  //       TextSpan(
                  //         text: ' and ',
                  //       ),
                  //       TextSpan(
                  //         text: 'Privacy Policy',
                  //         style: TextStyle(
                  //           decoration: TextDecoration.underline,
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //         recognizer: TapGestureRecognizer()
                  //           ..onTap = _onPrivacyPolicyTapped,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
