import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoExpenseWidget extends StatelessWidget {
  String message;
  NoExpenseWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: GoogleFonts.aBeeZee(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Tap the button below to split money",
          style: GoogleFonts.aBeeZee(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
