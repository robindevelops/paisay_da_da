// Extracted Custom Text Field
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  TextEditingController controller;

  CustomTextField({
    Key? key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword, // Hide text if it's a password field
      style: const TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(icon, color: Colors.black),
        contentPadding: const EdgeInsets.all(12),
        filled: true,
        fillColor: Colors.grey[200],
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

void _onTermsOfUseTapped() {
  print('Terms of Use tapped');
}

void _onPrivacyPolicyTapped() {
  print('Privacy Policy tapped');
}
