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
                    "Welcome to Paisay Da Da!",
                    style: GoogleFonts.aBeeZee(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Just a few things to keep in mind:",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  TermPoint("Use responsibly. Mazaaq thik hai, hadd mein."),
                  TermPoint("Your data = your trust. We respect both."),
                  TermPoint("We don’t take blame, only prayers."),
                  TermPoint("No kids under 13. Bacho, grow up first."),
                  TermPoint("Break the rules? Ban. No drama."),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            // const Divider(),
            // const SizedBox(height: 10),
            Text(
              "Made with ❤️ in Pakistan 🇵🇰",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Transform.rotate(
              angle: -0.05, // slight tilt
              child: Text(
                "Alyan\nShahid",
                style: GoogleFonts.rockSalt(
                  fontSize: 30,
                  color: AppThemes.splitGreen,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                ),
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
