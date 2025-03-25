import 'package:flutter/material.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';
import 'package:paisay_da_da/presentation/widgets/app_textfield.dart';

class CreategroupScreen extends StatefulWidget {
  const CreategroupScreen({super.key});

  @override
  State<CreategroupScreen> createState() => _CreategroupScreenState();
}

class _CreategroupScreenState extends State<CreategroupScreen> {
  TextEditingController groupName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Create Group",
        ),
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            // Group Icon (Funny Placeholder)
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: 2),
                color: Colors.grey[200],
              ),
              child: const Center(
                child: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 40,
                ),
              ),
            ),
            // const SizedBox(height: 10),

            const SizedBox(height: 30),

            // Group Name Field
            CustomTextField(
              hintText: "Group Name",
              icon: Icons.group,
              controller: groupName,
            ),

            const SizedBox(height: 20),

            // Create Group Button
            AppElevatedButton(
              text: "Create Group",
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Group Created! Now convince them to pay! 😜",
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // Another Funny Caption
            // const Text(
            //   "Pro Tip: Doston se udhaar maangna asaan hai,\nwapas lena impossible hai! 😂",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(fontSize: 12, color: Colors.grey),
            // ),
          ],
        ),
      ),
    );
  }
}
