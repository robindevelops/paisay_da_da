import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisay_da_da/presentation/widgets/app_elevated_button.dart';

class CreategroupScreen extends StatefulWidget {
  const CreategroupScreen({super.key});

  @override
  State<CreategroupScreen> createState() => _CreategroupScreenState();
}

class _CreategroupScreenState extends State<CreategroupScreen> {
  TextEditingController groupName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final groupProvider = Provider.of<GroupNotifier>(context);
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text(
          "Create Group",
        ),
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              // Group Icon (Funny Placeholder)
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
              ),
              // const SizedBox(height: 10),

              const SizedBox(height: 30),

              _buildInputField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
                hintText: "Group name",
                icon: Icons.group,
                controller: groupName,
              ),
              // Group Name Field

              const SizedBox(height: 20),

              AppElevatedButton(
                text: "Create Group",
                onPressed: () async {},
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
      ),
    );
  }
}

Widget _buildInputField({
  required TextEditingController controller,
  required String hintText,
  required IconData icon,
  String? Function(String?)? validator,
  TextInputType keyboardType = TextInputType.text,
}) {
  return TextFormField(
    validator: validator,
    controller: controller,
    keyboardType: keyboardType,
    style: GoogleFonts.poppins(fontSize: 16),
    obscureText: hintText.toLowerCase().contains("password"),
    decoration: InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
