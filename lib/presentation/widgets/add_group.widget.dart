import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          AppElevatedButton(
            text: "Start a Group",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreategroupScreen(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
