import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/presentation/notifier/friend.notifier.dart';
import 'package:provider/provider.dart';

class FriendSettingsScreen extends StatefulWidget {
  String email;

  FriendSettingsScreen({super.key, required this.email});

  @override
  State<FriendSettingsScreen> createState() => _FriendSettingsScreenState();
}

class _FriendSettingsScreenState extends State<FriendSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var friendNotifier = Provider.of<FriendNotifier>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text(
          "Settings",
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              "Edit",
              style: GoogleFonts.aBeeZee(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          Text(
            "Manage relationship",
            style: GoogleFonts.aBeeZee(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title: const Text(
              "Remove Friend",
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  final TextEditingController _messageController =
                      TextEditingController();

                  return AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: Text(
                      "Send Reminder",
                      style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold),
                    ),
                    content: TextField(
                      controller: _messageController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Enter your message...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppThemes.highlightGreen,
                        ),
                        onPressed: () async {
                          String message = _messageController.text.trim();
                          await friendNotifier.sendReminder(
                            context,
                            recieverEmail: widget.email,
                            messsage: message,
                          );
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Send",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            leading: const Icon(
              Icons.notification_add,
              color: Colors.black,
            ),
            title: const Text(
              "Send Reminder",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
