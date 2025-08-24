import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/add/add_members_screen.dart';

class NoGroupMemberWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "You are the only one in this group",
            style: GoogleFonts.aBeeZee(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 20),
          // AppElevatedButton(
          //   text: "Add People",
          //   onPressed: () {
          //     BaseHelper.showFriendsBottomSheet(context);
          //   },
          // )

          const SizedBox(height: 10),

          // Already have an account
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddMembersScreen(),
                ),
              );
            },
            child: Container(
              width: 280,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFBFFF60),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Add Members",
                textAlign: TextAlign.center,
                style: GoogleFonts.aBeeZee(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
