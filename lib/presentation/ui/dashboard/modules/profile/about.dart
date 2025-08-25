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
                    "Hey there! I’m Alyan, the guy behind this app. Ever had those 'forgot to pay' moments in your friend group? Yeah, me too. So I made this app to make sure everyone pays their share—on time! 😎\n\nAdd expenses, split bills, and show the total. No more awkward reminders. No more excuses. Just paisay da da!",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 24),
                  TermPoint(
                      "💰 Split bills easily: Group dinners, trips, or chai pe charcha, all covered."),
                  TermPoint(
                      "😂 Fun allowed: Throw jokes, memes, or sarcastic reminders, but keep it friendly."),
                  TermPoint(
                      "🔒 Safe & private: Your data is safe. Your secrets stay secret."),
                  TermPoint(
                      "👶 Age check: Under 13? Chill, come back when you’re older."),
                  TermPoint(
                      "🚫 Rule breakers beware: Mess with the system, and you might get banned (kidding… maybe)."),
                  TermPoint(
                      "📸 Screenshot-proof: Nobody can claim ‘I paid’ without proof."),
                  TermPoint(
                      "⚡ Quick reminders: Gentle nudges for friends who forget. No drama."),
                  const SizedBox(height: 30),
                ],
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
