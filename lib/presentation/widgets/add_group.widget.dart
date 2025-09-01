import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/core/themes/themes.dart';
import 'package:paisay_da_da/presentation/ui/dashboard/modules/group/create_group_screen.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';

class AddGroupWidget extends StatelessWidget {
  const AddGroupWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          Text(
            "Jitne marzi dost add kar lo…\npaisay wapas nahi milnay waalay!",
            style: GoogleFonts.aBeeZee(
              fontSize: 16,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CreategroupScreen();
                  },
                ),
              );
            },
            child: Container(
              width: 230,
              height: 50,
              // padding: EdgeInssets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: AppThemes.highlightGreen,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade700,
                  width: 1.4,
                ),
              ),
              child: Center(
                child: Text(
                  "Create Group",
                  style: GoogleFonts.aBeeZee(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
