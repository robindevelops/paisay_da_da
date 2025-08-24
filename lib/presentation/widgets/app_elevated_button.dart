// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/constants/constants.dart';
import 'package:paisay_da_da/core/themes/themes.dart';

class AppElevatedButton extends StatefulWidget {
  String text;
  void Function()? onPressed;
  Widget? icon;
  AppElevatedButton(
      {super.key, required this.text, required this.onPressed, this.icon});

  @override
  State<AppElevatedButton> createState() => _AppElevatedButtonState();
}

class _AppElevatedButtonState extends State<AppElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton.icon(
        icon: widget.icon,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          // backgroundColor: Color(0xFFFF9500),
          backgroundColor: AppThemes.primaryButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: widget.onPressed,
        label: Text(
          widget.text,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
