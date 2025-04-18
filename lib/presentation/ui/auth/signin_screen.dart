import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/presentation/notifier/auth.notifier.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/dashboard_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';
import 'package:paisay_da_da/presentation/widgets/app_textfield.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationNotifier>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Signin", style: GoogleFonts.aBeeZee(fontSize: 30)),
                    // SizedBox(height: 30),

                    SizedBox(height: 15), // Space between fields
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email is required";
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                            .hasMatch(value)) {
                          return "Enter a valid email";
                        }
                        return null;
                      },
                      hintText: "Email",
                      icon: Icons.email,
                      controller: emailController,
                    ),
                    SizedBox(height: 15),
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
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
                    authProvider.isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        : AppElevatedButton(
                            text: "Login Now",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // Navigator.pushNamed(context, '/dashboard');
                                bool success = await authProvider.signin(
                                  context: context,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );

                                if (success) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DashboardScreen(),
                                    ),
                                  );
                                }
                              }
                            },
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
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Signup",
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
      ),
    );
  }
}
