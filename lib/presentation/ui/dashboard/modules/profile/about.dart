import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/themes/themes.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "About Us",
          style: GoogleFonts.aBeeZee(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Text(
                    "About us",
                    style: GoogleFonts.aBeeZee(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "I’m Alyan. I made this app after too many dawat scenes where friends just ‘forgot’ to pay. So now, no more excuses. Add, split, and show them the total. Paisay da da, warna screenshot jayega group mein 😎",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TermPoint(
                      "This app is for splitting bills, not friendships."),
                  TermPoint("Mazaaq allowed — lekin limit mein."),
                  TermPoint("Data stays safe. Trust stays safer."),
                  TermPoint("Under 13? Jaao pehle baray ho jao."),
                  TermPoint("Break rules? Get banned. Simple."),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            Text(
              "Made with ❤️ for friends who forget 💰",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Transform.rotate(
              angle: -0.05,
              child: Text(
                "Alyan\nShahid",
                style: GoogleFonts.rockSalt(
                  fontSize: 30,
                  color: AppThemes.splitGreen,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class TermPoint extends StatelessWidget {
  final String text;
  const TermPoint(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 18, color: Colors.black)),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
