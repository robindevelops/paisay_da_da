// Extracted Custom Text Field
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  TextEditingController controller;
  TextInputType? keyboardType;
  String? Function(String?)? validator;
  void Function(String)? onChanged;

  CustomTextField(
      {Key? key,
      required this.hintText,
      required this.icon,
      this.isPassword = false,
      required this.controller,
      this.onChanged,
      this.keyboardType,
      this.validator})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.isPassword == true ? _obscureText : false,
      style: const TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        errorStyle: TextStyle(color: Colors.red),
        // errorBorder: OutlineInputBorder(borderSide: BorderSide.none),
        suffixIcon: widget.isPassword == true
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(widget.icon, color: Colors.black),
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
