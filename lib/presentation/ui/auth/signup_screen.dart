import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/notifier/auth.notifier.dart';
import 'package:paisay_da_da/presentation/notifier/loader.notifier.dart';
import 'package:paisay_da_da/presentation/ui/auth/signin_screen.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/dashboard_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>(); // Form key

  TextEditingController firstNamecontroller = TextEditingController();
  TextEditingController lastNamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    var loaderNotifier = Provider.of<LoaderNotifier>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // attach form key
            child: Column(
              children: [
                loaderNotifier.isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        "Sign Up Now",
                        style: GoogleFonts.poppins(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: AppThemes.splitGreen,
                        ),
                      ),
                const SizedBox(height: 5),
                Text(
                  "Your money, made simple!",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 20),
                _buildInputField(
                  hintText: "First Name",
                  icon: Icons.person_2_outlined,
                  controller: firstNamecontroller,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "First name is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                _buildInputField(
                  hintText: "Last Name",
                  icon: Icons.person_2_outlined,
                  controller: lastNamecontroller,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Last name is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                _buildInputField(
                  hintText: "Email",
                  icon: Icons.email_outlined,
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Email is required";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                _buildInputField(
                  hintText: "Password",
                  icon: Icons.lock_outlined,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is required";
                    }
                    if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                _buildInputField(
                  hintText: "Confirm Password",
                  icon: Icons.lock_outlined,
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm your password";
                    }
                    if (value != passwordController.text) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                AppElevatedButton(
                  // icon: Icon(
                  //   Icons.email_outlined,
                  //   color: Colors.white,
                  // ),
                  text: "Sign Up Now",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool success = await authNotifier.signup(
                        context,
                        firstName: firstNamecontroller.text,
                        lastName: lastNamecontroller.text,
                        email: emailcontroller.text,
                        password: passwordController.text,
                        fcmToken: HiveDatabase.getValue("fcmToken"),
                      );
                      if (success) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardScreen(),
                          ),
                        );
                      }
                      // clear();
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: GoogleFonts.aBeeZee(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SigninScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Signin",
                        style: TextStyle(
                          color: AppThemes.splitGreen,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void clear() {
    firstNamecontroller.clear();
    lastNamecontroller.clear();
    emailcontroller.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}

Widget _buildInputField({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  String? Function(String?)? validator,
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextFormField(
    validator: validator,
    controller: controller,
    keyboardType: keyboardType,
    style: GoogleFonts.poppins(fontSize: 16),
    obscureText: hintText.toLowerCase().contains("password"),
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
