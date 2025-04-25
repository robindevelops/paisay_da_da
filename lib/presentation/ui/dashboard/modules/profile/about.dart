import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "About Us",
          style: TextStyle(color: Colors.white),
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
                  Center(
                    child: Text(
                      "Welcome to Paisay Da Da!",
                      style: GoogleFonts.aBeeZee(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "By using this app, you agree to the following terms. Don't worry, it's painless:",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24),
                  TermPoint("App fair use ke liye hai. Bakaiti na karna."),
                  TermPoint("Secrets safe hain. Dil aur data dono."),
                  TermPoint(
                      "Nuksaan ka zimmedar khud ho. Hum sirf dua dein ge."),
                  TermPoint("13+ only. Chhotay bhai, pehle baray ho jao."),
                  TermPoint(
                      "Data sirf app behtar banane ke liye. Na aliens ko bhejain ge, na rishtedaron ko."),
                  TermPoint("Rule tode? Ban ho jao ge. Aur rona bhi mana hai."),
                  TermPoint(
                      "3 baje raat ko biryani khao, app kholo. Full support!"),
                  SizedBox(height: 30),
                  Divider(color: Colors.white24),
                  SizedBox(height: 20),
                ],
              ),
            ),
            // Footer with humorous touch
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Center(
                child: Text(
                  "Made with ❤️ for Pakistan 🇵🇰",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
