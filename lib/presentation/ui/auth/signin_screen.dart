import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/presentation/ui/auth/signup_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';
import 'package:paisay_da_da/presentation/widgets/app_textfield.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
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
                  Text("Signin", style: GoogleFonts.aBeeZee(fontSize: 30)),
                  // SizedBox(height: 30),

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
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password??",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  AppElevatedButton(
                    text: "Login Now",
                    onPressed: () {},
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont have an account?",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(context, '/signin');
                        },
                        child: Text(
                          "Createone",
                          style: GoogleFonts.aBeeZee(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
