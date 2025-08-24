// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/themes/themes.dart';

class AppOutlineButton extends StatefulWidget {
  String text;
  Widget? icon;
  void Function()? onPressed;

  AppOutlineButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.icon});

  @override
  State<AppOutlineButton> createState() => _AppOutlineButtonState();
}

class _AppOutlineButtonState extends State<AppOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: OutlinedButton.icon(
        icon: widget.icon,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50),
          // backgroundColor: Color(0xFFFF9500),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: widget.onPressed,
        label: Text(
          widget.text,
          style: GoogleFonts.poppins(
            color: Colors.black,
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
