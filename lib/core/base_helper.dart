import 'package:awesome_top_snackbar/awesome_top_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/themes.dart';
import 'package:paisay_da_da/data/local/hive.dart';
import 'package:paisay_da_da/presentation/ui/welcome/welcome_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';

class BaseHelper {
  /// Function to show a bottom sheet for logout confirmation

  static void showDeleteAccountBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Humorous Title
            Text(
              "Are You Sure You Want To Delete Your Account?",
              style: GoogleFonts.aBeeZee(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),

            // Fun Emoji and Humor Text
            Icon(
              Icons.delete_forever,
              size: 60,
              color: Colors.red,
            ),
            const SizedBox(height: 10),
            Text(
              "Deleting your account means you'll miss us... 😢",
              style: GoogleFonts.patrickHand(
                fontSize: 18,
                color: Colors.black.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "Are you sure you want to go? We’ll be sad!",
              style: GoogleFonts.aBeeZee(
                fontSize: 16,
                color: Colors.black.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Confirmation Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  child: Text(
                    "Nah, I’m Staying!",
                    style: GoogleFonts.aBeeZee(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Perform deletion action here
                    Navigator.pop(context);
                    // Show a message or proceed with account deletion
                  },
                  child: Text(
                    "Yes, Delete It! 💀",
                    style: GoogleFonts.aBeeZee(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static void showLogoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.logout, size: 40, color: Colors.black),
              SizedBox(height: 10),
              Text(
                "Are you sure you want to logout?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppThemes.splitGreen,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        HiveDatabase.storelogin(false);
                        HiveDatabase.clearAll();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                        );
                        BaseHelper.showSnackBar(
                          context,
                          "Logout Successfully",
                          Colors.green,
                        );
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  /// Function to show a snackbar with a message

  static void showSnackBar(context, String message, Color color) {
    awesomeTopSnackbar(
      backgroundColor: color,
      context,
      message,
      iconWithDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(),
        color: Colors.white,
      ),
      icon: Icon(
        Icons.done,
        color: Colors.black,
      ),
    );
  }

  /// Function to show a bottom sheet with split options

  static final List<String> splitOptions = [
    "Paid by me, split equally",
    "I owed full",
    "Paid by other",
    "Split money, I owed by others"
  ];

  static void showSplitOptions(context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.black, // Black background
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: splitOptions
                .map(
                  (option) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: ListTile(
                      title: Text(
                        option,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white, // White text
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white70,
                        size: 18,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  /// Function to show a bottom sheet for adding friends

  static void showFriendsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.6,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Add People",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 16),
                // CustomTextField(
                //   hintText: "Enter name",
                //   icon: Icons.person,
                //   controller: ,
                // ),

                Expanded(
                  child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {},
                        trailing: Checkbox(
                          activeColor: Colors.black,
                          value: true,
                          onChanged: (value) {},
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(),
                            SizedBox(width: 10),
                            const Text("Furqan abid"),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 25),
                AppElevatedButton(
                  text: "Add",
                  onPressed: () {},
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
